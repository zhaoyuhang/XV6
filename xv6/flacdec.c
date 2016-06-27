#include <stdint.h>
#include <stdio.h>

#include "flacdec.h"

typedef struct previous_value {
    DECODE_TYPE value;
    struct previous_value *next;
} previous_value_t;

typedef struct {
    uint8_t rice_parameter_size;
    uint8_t rice_parameter;
    uint8_t partition_order;
    uint8_t is_first_partition;
    uint8_t has_escape_code;
    uint8_t escape_bits_per_sample;
    uint16_t remaining_nb_samples;
} rice_coding_info_t;

typedef struct {
    uint8_t type;
    uint8_t wasted_bits_per_sample;
    uint8_t bits_per_sample;
    int data_input_position;
    uint8_t data_input_shift;
    DECODE_UTYPE value;
    previous_value_t previous_values[32];
    previous_value_t *next_out;
    uint8_t lpc_precision;
    int8_t lpc_shift;
    int16_t coeffs[32];
    rice_coding_info_t residual_info;
    uint8_t has_parameters;
} subframe_info_t;

typedef struct {
    uint16_t block_size;
    uint8_t channel_assignement;
    uint8_t nb_channels;
    uint8_t bits_per_sample;
#ifdef STEREO_ONLY
    subframe_info_t subframes_info[2];
#else
    subframe_info_t subframes_info[8];
#endif
} frame_info_t;

static int get_flac_stream_info(data_input_t *data_input, stream_info_t *stream_info) {

    uint8_t *buffer = NULL;
    int position = 0;

    if (should_refill_input_buffer(data_input, 42)) if (refill_input_buffer_at_least(data_input, 42) == -1)
        return -1;

    buffer = data_input->buffer;
    position = data_input->position;

    if ((buffer[position] != 'f') || (buffer[position + 1] != 'L') || (buffer[position + 2] != 'a') ||
        (buffer[position + 3] != 'C')) {
        fprintf(stderr, "Not a flac file\n");
        return -1;
    }

    position += 8;

    stream_info->min_block_size = (buffer[position] << 8) | buffer[position + 1];
    position += 2;

    stream_info->max_block_size = (buffer[position] << 8) | buffer[position + 1];
    position += 2;

    stream_info->min_frame_size = (buffer[position] << 16) | (buffer[position + 1] << 8) | buffer[position + 2];
    position += 3;

    stream_info->max_frame_size = (buffer[position] << 16) | (buffer[position + 1] << 8) | buffer[position + 2];
    position += 3;

    stream_info->sample_rate = (buffer[position] << 12) | (buffer[position + 1] << 4) | (buffer[position + 2] >> 4);
    position += 2;

    stream_info->nb_channels = ((buffer[position] >> 1) & 0x07) + 1;

    stream_info->bits_per_sample = (((buffer[position] & 0x01) << 4) | (buffer[position + 1] >> 4)) + 1;
    position += 1;

#ifndef DISALLOW_64_BITS
    stream_info->nb_samples =
            (((uint64_t) buffer[position] & 0x0F) << 32) | (buffer[position + 1] << 24) | (buffer[position + 2] << 16) |
            (buffer[position + 3] << 8) | buffer[position + 4];
#endif

    position += 5;

    stream_info->md5[0] = buffer[position++];
    stream_info->md5[1] = buffer[position++];
    stream_info->md5[2] = buffer[position++];
    stream_info->md5[3] = buffer[position++];
    stream_info->md5[4] = buffer[position++];
    stream_info->md5[5] = buffer[position++];
    stream_info->md5[6] = buffer[position++];
    stream_info->md5[7] = buffer[position++];
    stream_info->md5[8] = buffer[position++];
    stream_info->md5[9] = buffer[position++];
    stream_info->md5[10] = buffer[position++];
    stream_info->md5[11] = buffer[position++];
    stream_info->md5[12] = buffer[position++];
    stream_info->md5[13] = buffer[position++];
    stream_info->md5[14] = buffer[position++];
    stream_info->md5[15] = buffer[position++];

    data_input->position = position;

    return 0;

}

static int skip_metadata(data_input_t *data_input) {

    uint8_t was_last = 0;

    do {
        uint32_t length = 0;
        uint8_t *buffer = NULL;
        int position = 0;

        if (should_refill_input_buffer(data_input, 4)) if (refill_input_buffer_at_least(data_input, 4) == -1)
            return -1;

        buffer = data_input->buffer;
        position = data_input->position;

        was_last = buffer[position] >> 7;
        position += 1;

        length = (buffer[position] << 16) | (buffer[position + 1] << 8) | buffer[position + 2];
        data_input->position = position + 3;

        if (skip_nb_bits(data_input, (int) (length * 8)) == -1)
            return -1;
    } while (!was_last);

    return 0;

}

static int read_frame_header(data_input_t *data_input, uint8_t bits_per_sample, frame_info_t *frame_info) {

    uint8_t blocking_strategy = 0;
    uint8_t sample_rate = 0;
    uint8_t *buffer = NULL;
    int position = 0;

    if (should_refill_input_buffer(data_input, 16)) {
        int error_code = refill_input_buffer(data_input);
        if (error_code == -1)
            return -1;
        if (error_code == 0)
            return 0;
        if (data_input->read_size < 16)
            return 0;
    }

    buffer = data_input->buffer;
    position = data_input->position;

    if ((buffer[position] != 0xFF) || ((buffer[position + 1] & 0xFC) != 0xF8)) {
        fprintf(stderr, "Something is wrong with the synchro.\n");
        return -1;
    }

    blocking_strategy = buffer[position + 1] & 0x01;
    position += 2;

    frame_info->block_size = buffer[position] >> 4;
    sample_rate = buffer[position] & 0x0F;
    position += 1;

    frame_info->channel_assignement = buffer[position] >> 4;
    frame_info->bits_per_sample = (buffer[position] >> 1) & 0x07;
    position += 1;

    if (frame_info->bits_per_sample == 0) {
        frame_info->bits_per_sample = bits_per_sample;
    } else {
        switch (frame_info->bits_per_sample) {
            case 1:
                frame_info->bits_per_sample = 8;
                break;

            case 2:
                frame_info->bits_per_sample = 12;
                break;

            case 4:
                frame_info->bits_per_sample = 16;
                break;

            case 5:
                frame_info->bits_per_sample = 20;
                break;

            case 6:
                frame_info->bits_per_sample = 24;
        }
    }

    if (blocking_strategy) {
#ifndef DISALLOW_64_BITS
        uint64_t sample_nb = 0;
#endif
        uint8_t nb_coding_bytes = 1;

        if ((buffer[position] & 0x80) && (buffer[position] & 0x40)) {
            if (buffer[position] & 0x20) if (buffer[position] & 0x10) if (buffer[position] & 0x08) if (
                    buffer[position] & 0x04)
                nb_coding_bytes = 6;
            else
                nb_coding_bytes = 5;
            else
                nb_coding_bytes = 4;
            else
                nb_coding_bytes = 3;
            else
                nb_coding_bytes = 2;
        }

#ifdef DISALLOW_64_BITS
        position += nb_coding_bytes;
#else
        if (nb_coding_bytes == 1) {
            sample_nb = buffer[position];
            ++position;
        } else {
            sample_nb = buffer[position] & (0xFFu >> nb_coding_bytes);
            ++position;
            --nb_coding_bytes;
            while (nb_coding_bytes) {
                sample_nb <<= 6;
                sample_nb |= buffer[position] & 0x3F;
                ++position;
                --nb_coding_bytes;
            }
        }
#endif

    } else {
        uint32_t frame_nb = 0;
        uint8_t nb_coding_bytes = 1;

        if ((buffer[position] & 0x80) && (buffer[position] & 0x40)) {
            if (buffer[position] & 0x20) if (buffer[position] & 0x10) if (buffer[position] & 0x08) if (
                    buffer[position] & 0x04) if (buffer[position] & 0x02)
                nb_coding_bytes = 7;
            else
                nb_coding_bytes = 6;
            else
                nb_coding_bytes = 5;
            else
                nb_coding_bytes = 4;
            else
                nb_coding_bytes = 3;
            else
                nb_coding_bytes = 2;
        }

        if (nb_coding_bytes == 1) {
            frame_nb = buffer[position];
            ++position;
        } else {
            frame_nb = buffer[position] & (0xFFu >> nb_coding_bytes);
            ++position;
            --nb_coding_bytes;
            while (nb_coding_bytes) {
                frame_nb <<= 6;
                frame_nb |= buffer[position] & 0x3F;
                ++position;
                --nb_coding_bytes;
            }
        }
    }

    if (frame_info->block_size == 0x06) {
        frame_info->block_size = buffer[position] + 1;
        position += 1;
    } else if (frame_info->block_size == 0x07) {
        frame_info->block_size = ((buffer[position] << 8) | buffer[position + 1]) + 1;
        position += 2;
    } else {
        switch (frame_info->block_size) {
            case 1:
                frame_info->block_size = 192;
                break;

            case 2:
                frame_info->block_size = 576;
                break;

            case 3:
                frame_info->block_size = 1152;
                break;

            case 4:
                frame_info->block_size = 2304;
                break;

            case 5:
                frame_info->block_size = 4608;
                break;

            case 8:
                frame_info->block_size = 256;
                break;

            case 9:
                frame_info->block_size = 512;
                break;

            case 10:
                frame_info->block_size = 1024;
                break;

            case 11:
                frame_info->block_size = 2048;
                break;

            case 12:
                frame_info->block_size = 4096;
                break;

            case 13:
                frame_info->block_size = 8192;
                break;

            case 14:
                frame_info->block_size = 16384;
                break;

            case 15:
                frame_info->block_size = 32768;
        }
    }

    if (sample_rate == 0x0C)
        position += 1;
    else if ((sample_rate == 0x0D) || (sample_rate == 0x0E))
        position += 2;

    data_input->position = position + 1;

    return 1;

}

static int read_subframe_header(data_input_t *data_input, subframe_info_t *subframe_info) {

    int error_code = 0;
    uint8_t partial_subframe_header_data = get_shifted_bits(data_input, 8, &error_code);
    if (error_code == -1)
        return -1;

    subframe_info->type = (partial_subframe_header_data >> 1) & 0x3F;
    subframe_info->wasted_bits_per_sample = partial_subframe_header_data & 0x01;

    if (subframe_info->wasted_bits_per_sample) {
        while (get_one_shifted_bit(data_input, &error_code) == 0)
            ++subframe_info->wasted_bits_per_sample;
        if (error_code == -1)
            return -1;
    }

    return 0;

}

static DECODE_TYPE get_next_rice_residual(data_input_t *data_input, rice_coding_info_t *residual_info,
                                          uint16_t block_size, uint8_t predictor_order, int *error_code) {

    static uint16_t nb_partitions[] = {1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768};
    DECODE_TYPE value = 0;

    if (residual_info->remaining_nb_samples == 0) {
        residual_info->rice_parameter = get_shifted_bits(data_input, residual_info->rice_parameter_size, error_code);
        if (*error_code == -1)
            return 0;

        residual_info->has_escape_code =
                ((residual_info->rice_parameter_size == 4) && (residual_info->rice_parameter == 0x0F)) ||
                ((residual_info->rice_parameter_size == 5) && (residual_info->rice_parameter == 0x1F));

        if (residual_info->has_escape_code) {
            residual_info->escape_bits_per_sample = get_shifted_bits(data_input, 5, error_code);
            if (*error_code == -1)
                return 0;
        }

        if (residual_info->is_first_partition) {
            residual_info->is_first_partition = 0;
            residual_info->remaining_nb_samples = residual_info->partition_order == 0 ? block_size - predictor_order :
                                                  (block_size / nb_partitions[residual_info->partition_order]) -
                                                  predictor_order;
        } else {
            residual_info->remaining_nb_samples = block_size / nb_partitions[residual_info->partition_order];
        }
    }

    if (!residual_info->has_escape_code) {
        DECODE_UTYPE msb = 0;

        while (get_one_shifted_bit(data_input, error_code) == 0)
            ++msb;
        if (*error_code == -1)
            return 0;

        if (residual_info->rice_parameter == 0) {
            if (msb & 0x01)
                value = -(msb >> 1) - 1;
            else
                value = msb >> 1;
            --residual_info->remaining_nb_samples;
            return value;
        } else {
            DECODE_UTYPE lsb = 0;

            lsb = get_shifted_bits(data_input, residual_info->rice_parameter, error_code);
            if (*error_code == -1)
                return 0;
            value = (msb << (residual_info->rice_parameter - 1)) | (lsb >> 1);
            if (lsb & 0x1)
                value = -(value + 1);
        }
        --residual_info->remaining_nb_samples;
        return value;
    } else {
        value = convert_to_signed(get_shifted_bits(data_input, residual_info->escape_bits_per_sample, error_code),
                                  residual_info->escape_bits_per_sample);
        if (*error_code == -1)
            return 0;
        --residual_info->remaining_nb_samples;
    }

    return value;

}

static uint16_t decode_constant(data_input_t *data_input, data_output_t *data_output, frame_info_t *frame_info,
                                uint8_t channel_nb, uint16_t crt_sample, int *error_code) {

    subframe_info_t *subframe = frame_info->subframes_info + channel_nb;

    if (!subframe->has_parameters) {
        subframe->value = get_shifted_bits(data_input, subframe->bits_per_sample - subframe->wasted_bits_per_sample,
                                           error_code) << subframe->wasted_bits_per_sample;
        if (*error_code == -1)
            return 0;

        subframe->has_parameters = 1;
    }

    for (; crt_sample < frame_info->block_size; ++crt_sample) {
        *error_code = put_shifted_bits(data_output, subframe->value, subframe->bits_per_sample,
                                       frame_info->channel_assignement, channel_nb);

        if (*error_code == -1)
            return 0;

        if (*error_code == 0) {
            if (subframe->data_input_position == -1) {
                subframe->data_input_position = get_position(data_input);
                subframe->data_input_shift = data_input->shift;
            }

            return crt_sample;
        }
    }

    return frame_info->block_size;

}

static uint16_t decode_verbatim(data_input_t *data_input, data_output_t *data_output, frame_info_t *frame_info,
                                uint8_t channel_nb, uint16_t crt_sample, int *error_code) {

    subframe_info_t *subframe = frame_info->subframes_info + channel_nb;

    if (crt_sample != 0) {
        *error_code = put_shifted_bits(data_output, subframe->value, subframe->bits_per_sample,
                                       frame_info->channel_assignement, channel_nb);
        if (*error_code == -1)
            return 0;
        ++crt_sample;
    }

    for (; crt_sample < frame_info->block_size; ++crt_sample) {
        DECODE_UTYPE value = get_shifted_bits(data_input, subframe->bits_per_sample - subframe->wasted_bits_per_sample,
                                              error_code) << subframe->wasted_bits_per_sample;
        if (*error_code == -1)
            return -1;

        *error_code = put_shifted_bits(data_output, value, subframe->bits_per_sample, frame_info->channel_assignement,
                                       channel_nb);

        if (*error_code == -1)
            return 0;

        if (*error_code == 0) {
            subframe->value = value;
            subframe->data_input_position = get_position(data_input);
            subframe->data_input_shift = data_input->shift;

#ifdef STEREO_ONLY
            if((channel_nb == 0) && (frame_info->subframes_info[0].data_input_position == -1)) {
#else
            if (((channel_nb + 1) < frame_info->nb_channels) &&
                (frame_info->subframes_info[channel_nb + 1].data_input_position == -1)) {
#endif
                if (skip_nb_bits(data_input, (subframe->bits_per_sample - subframe->wasted_bits_per_sample) *
                                             (frame_info->block_size - (crt_sample + 1))) == -1) {
                    *error_code = -1;
                    return 0;
                }
            }

            return crt_sample;
        }
    }

    return frame_info->block_size;

}


#define INIT_ONE_WARMUP(data_input, subframe, index, next_index, error_code) \
    do { \
        (subframe)->previous_values[(index)].value = convert_to_signed(get_shifted_bits((data_input), (subframe)->bits_per_sample - (subframe)->wasted_bits_per_sample, (error_code)), (subframe)->bits_per_sample - (subframe)->wasted_bits_per_sample); \
        (subframe)->previous_values[(index)].next = (subframe)->previous_values + (next_index); \
    } while(0)


#define OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, index, crt_sample, error_code) \
    do { \
        if((*(error_code) = put_shifted_bits((data_output), (subframe)->previous_values[(index)].value << (subframe)->wasted_bits_per_sample, (subframe)->bits_per_sample, (frame_info)->channel_assignement, (channel_nb))) != 1) \
            break; \
        ++(crt_sample); \
    } while(0)

#ifdef STEREO_ONLY
#define SKIP_INPUT(data_input, frame_info, subframe, channel_nb, order,  starting_sample, error_code) \
    do { \
        (subframe)->data_input_position = get_position((data_input)); \
        (subframe)->data_input_shift = (data_input)->shift; \
        if(((channel_nb) == 0) && ((frame_info)->subframes_info[1].data_input_position == -1)) { \
            uint16_t crt_skipped_sample = (starting_sample); \
            rice_coding_info_t residual_info = (subframe)->residual_info; \
            for(; crt_skipped_sample < frame_info->block_size; ++crt_skipped_sample) \
                get_next_rice_residual((data_input), &residual_info, (frame_info)->block_size, (order), (error_code)); \
            if(*(error_code) == -1) \
                return 0; \
        } \
    } while(0)
#else
#define SKIP_INPUT(data_input, frame_info, subframe, channel_nb, order, starting_sample, error_code) \
    do { \
        (subframe)->data_input_position = get_position((data_input)); \
        (subframe)->data_input_shift = (data_input)->shift; \
        if(((channel_nb + 1) < frame_info->nb_channels) && (frame_info->subframes_info[channel_nb + 1].data_input_position == -1)) { \
            uint16_t crt_skipped_sample = (starting_sample); \
            rice_coding_info_t residual_info = (subframe)->residual_info; \
            for(; crt_skipped_sample < frame_info->block_size; ++crt_skipped_sample) \
                get_next_rice_residual((data_input), &residual_info, (frame_info)->block_size, (order), (error_code)); \
            if(*(error_code) == -1) \
                return 0; \
        } \
    } while(0)
#endif

static uint16_t decode_fixed(data_input_t *data_input, data_output_t *data_output, frame_info_t *frame_info,
                             uint8_t channel_nb, uint16_t crt_sample, int *error_code) {

    subframe_info_t *subframe = frame_info->subframes_info + channel_nb;
    uint8_t order = subframe->type - 8;

    if (!subframe->has_parameters) {
        uint8_t residual_coding_method = 0;

        if (order) {
            switch (order) {
                case 4:
                    INIT_ONE_WARMUP(data_input, subframe, 0, 1, error_code);

                case 3:
                    INIT_ONE_WARMUP(data_input, subframe, order - 3, order - 2, error_code);

                case 2:
                    INIT_ONE_WARMUP(data_input, subframe, order - 2, order - 1, error_code);

                case 1:
                    INIT_ONE_WARMUP(data_input, subframe, order - 1, order, error_code);
            }

            if (*error_code == -1)
                return 0;

            if (order > 1)
                subframe->previous_values[order - 1].next = subframe->previous_values;
        }

        subframe->next_out = subframe->previous_values;

        residual_coding_method = get_shifted_bits(data_input, 2, error_code);
        if (*error_code == -1)
            return 0;

        switch (residual_coding_method) {
            case 0:
                subframe->residual_info.rice_parameter_size = 4;
                break;

            case 1:
                subframe->residual_info.rice_parameter_size = 5;
                break;

            default:
                fprintf(stderr, "Invalid residual encoding method\n");
                *error_code = -1;
                return 0;
        }

        subframe->residual_info.rice_parameter = 0;
        subframe->residual_info.has_escape_code = 0;
        subframe->residual_info.escape_bits_per_sample = 0;
        subframe->residual_info.remaining_nb_samples = 0;
        subframe->residual_info.is_first_partition = 1;

        subframe->residual_info.partition_order = get_shifted_bits(data_input, 4, error_code);
        if (*error_code == -1)
            return 0;

        subframe->has_parameters = 1;

        if (!order) {
            subframe->previous_values[0].value = get_next_rice_residual(data_input, &(subframe->residual_info),
                                                                        frame_info->block_size, order, error_code);
            if (*error_code == -1)
                return 0;
        }
    }

    if (crt_sample < order) {
        switch (order - crt_sample) {
            case 4:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, 0, crt_sample, error_code);

            case 3:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 2:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 1:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);
                goto decode_fixed_subframe;
        }

        if (*error_code == -1)
            return 0;

        SKIP_INPUT(data_input, frame_info, subframe, channel_nb, order, order, error_code);
        return crt_sample;
    } else {
        *error_code = put_shifted_bits(data_output, subframe->next_out->value << subframe->wasted_bits_per_sample,
                                       subframe->bits_per_sample, frame_info->channel_assignement, channel_nb);
        if (*error_code == -1)
            return 0;

        ++crt_sample;
        if (order > 1)
            subframe->next_out = subframe->next_out->next;
    }

    decode_fixed_subframe:;
    switch (order) {
        case 0:
            for (; crt_sample < frame_info->block_size; ++crt_sample) {
                DECODE_TYPE value = get_next_rice_residual(data_input, &(subframe->residual_info),
                                                           frame_info->block_size, 0, error_code);
                if (*error_code == -1)
                    return 0;

                *error_code = put_shifted_bits(data_output, value << subframe->wasted_bits_per_sample,
                                               subframe->bits_per_sample, frame_info->channel_assignement, channel_nb);
                if (*error_code == -1)
                    return 0;

                if (*error_code == 0) {
                    subframe->previous_values[0].value = value;
                    goto buffer_full_error;
                }
            }

            return frame_info->block_size;

#define OUTPUT_VALUE(data_output, frame_info, subframe, channel_nb, value, error_code) \
    do { \
        *(error_code) = put_shifted_bits((data_output), (value) << (subframe)->wasted_bits_per_sample, (subframe)->bits_per_sample, (frame_info)->channel_assignement, (channel_nb)); \
        if(*(error_code) == -1) \
            return 0; \
        if(*(error_code) == 0) \
            goto buffer_full_error; \
    } while(0)

        case 1:
            for (; crt_sample < frame_info->block_size; ++crt_sample) {
                DECODE_TYPE value = subframe->previous_values[0].value +
                                    get_next_rice_residual(data_input, &(subframe->residual_info),
                                                           frame_info->block_size, 1, error_code);
                subframe->previous_values[0].value = value;

                if (*error_code == -1)
                    return 0;

                OUTPUT_VALUE(data_output, frame_info, subframe, channel_nb, value, error_code);
            }

            return frame_info->block_size;

        case 2:
            for (; crt_sample < frame_info->block_size; ++crt_sample) {
                DECODE_TYPE value = (subframe->next_out->next->value << 1) - subframe->next_out->value +
                                    get_next_rice_residual(data_input, &(subframe->residual_info),
                                                           frame_info->block_size, 2, error_code);
                subframe->next_out->value = value;

                if (*error_code == -1)
                    return 0;

                OUTPUT_VALUE(data_output, frame_info, subframe, channel_nb, value, error_code);

                subframe->next_out = subframe->next_out->next;
            }

            return frame_info->block_size;

        case 3:
            for (; crt_sample < frame_info->block_size; ++crt_sample) {
                DECODE_TYPE value =
                        ((subframe->next_out->next->next->value << 1) + subframe->next_out->next->next->value) -
                        ((subframe->next_out->next->value << 1) + subframe->next_out->next->value) +
                        subframe->next_out->value +
                        get_next_rice_residual(data_input, &(subframe->residual_info), frame_info->block_size, 3,
                                               error_code);
                subframe->next_out->value = value;

                if (*error_code == -1)
                    return 0;

                OUTPUT_VALUE(data_output, frame_info, subframe, channel_nb, value, error_code);

                subframe->next_out = subframe->next_out->next;
            }

            return frame_info->block_size;

        case 4:
            for (; crt_sample < frame_info->block_size; ++crt_sample) {
                DECODE_TYPE value = (subframe->next_out->next->next->next->value << 2) -
                                    (((subframe->next_out->next->next->value << 1) +
                                      subframe->next_out->next->next->value) << 1) +
                                    (subframe->next_out->next->value << 2) - subframe->next_out->value +
                                    get_next_rice_residual(data_input, &(subframe->residual_info),
                                                           frame_info->block_size, 4, error_code);
                subframe->next_out->value = value;

                if (*error_code == -1)
                    return 0;

                OUTPUT_VALUE(data_output, frame_info, subframe, channel_nb, value, error_code);

                subframe->next_out = subframe->next_out->next;
            }

            return frame_info->block_size;

#undef OUTPUT_VALUE

    }


    buffer_full_error:;
    SKIP_INPUT(data_input, frame_info, subframe, channel_nb, order, crt_sample + 1, error_code);
    return crt_sample;

}


/**
 * Decode a LPC subframe into the data output sink. In a LPC subframe, samples
 * are encoded using FIR linear prediction of one to thirty-second order.
 *
 * @param data_input  Parameters, warm-up samples and residuals are read from
 *                    there.
 * @param data_output The decoded samples are outputed there.
 * @param frame_info  Provide usefull informations like the number of samples
 *                    and information on the subframe.
 * @param channel_nb  Indicate which channel in the channel assignement we are
 *                    currently outputing.
 * @param crt_sample  The number of sample already decoded by a call to this
 *                    function for the current subframe (warmup samples
 *                    included).
 * @param error_code  -1 if an error occured, 0 else.
 *
 * @return Return the number of outputed samples for the current subframe.
 */
static uint16_t decode_lpc(data_input_t *data_input, data_output_t *data_output, frame_info_t *frame_info,
                           uint8_t channel_nb, uint16_t crt_sample, int *error_code) {

    subframe_info_t *subframe = frame_info->subframes_info + channel_nb;
    uint8_t order = (subframe->type & 0x1F) + 1;
    static uint32_t dividers[] = {1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536};

    if (!subframe->has_parameters) {
        uint8_t i = 0;
        uint8_t residual_coding_method = 0;

        switch (order) {
            case 32:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 31:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 30:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 29:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 28:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 27:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 26:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 25:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 24:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 23:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 22:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 21:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 20:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 19:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 18:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 17:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 16:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 15:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 14:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 13:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 12:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 11:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 10:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 9:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 8:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 7:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 6:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 5:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 4:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 3:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 2:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
                ++i;

            case 1:
                INIT_ONE_WARMUP(data_input, subframe, i, i + 1, error_code);
        }

        if (*error_code == -1)
            return 0;

        subframe->previous_values[order - 1].next = subframe->previous_values;
        subframe->next_out = subframe->previous_values;

        subframe->lpc_precision = get_shifted_bits(data_input, 4, error_code) + 1;
        if (*error_code == -1)
            return 0;

        subframe->lpc_shift = convert_to_signed(get_shifted_bits(data_input, 5, error_code), 5);
        if (*error_code == -1)
            return 0;

#define INIT_ONE_COEFF(data_input, subframe, index, error_code) \
    do { \
        (subframe)->coeffs[(index)] = convert_to_signed(get_shifted_bits((data_input), (subframe)->lpc_precision, (error_code)), (subframe)->lpc_precision); \
    } while(0)

        switch (order) {
            case 32:
                INIT_ONE_COEFF(data_input, subframe, 0, error_code);

            case 31:
                INIT_ONE_COEFF(data_input, subframe, order - 31, error_code);

            case 30:
                INIT_ONE_COEFF(data_input, subframe, order - 30, error_code);

            case 29:
                INIT_ONE_COEFF(data_input, subframe, order - 29, error_code);

            case 28:
                INIT_ONE_COEFF(data_input, subframe, order - 28, error_code);

            case 27:
                INIT_ONE_COEFF(data_input, subframe, order - 27, error_code);

            case 26:
                INIT_ONE_COEFF(data_input, subframe, order - 26, error_code);

            case 25:
                INIT_ONE_COEFF(data_input, subframe, order - 25, error_code);

            case 24:
                INIT_ONE_COEFF(data_input, subframe, order - 24, error_code);

            case 23:
                INIT_ONE_COEFF(data_input, subframe, order - 23, error_code);

            case 22:
                INIT_ONE_COEFF(data_input, subframe, order - 22, error_code);

            case 21:
                INIT_ONE_COEFF(data_input, subframe, order - 21, error_code);

            case 20:
                INIT_ONE_COEFF(data_input, subframe, order - 20, error_code);

            case 19:
                INIT_ONE_COEFF(data_input, subframe, order - 19, error_code);

            case 18:
                INIT_ONE_COEFF(data_input, subframe, order - 18, error_code);

            case 17:
                INIT_ONE_COEFF(data_input, subframe, order - 17, error_code);

            case 16:
                INIT_ONE_COEFF(data_input, subframe, order - 16, error_code);

            case 15:
                INIT_ONE_COEFF(data_input, subframe, order - 15, error_code);

            case 14:
                INIT_ONE_COEFF(data_input, subframe, order - 14, error_code);

            case 13:
                INIT_ONE_COEFF(data_input, subframe, order - 13, error_code);

            case 12:
                INIT_ONE_COEFF(data_input, subframe, order - 12, error_code);

            case 11:
                INIT_ONE_COEFF(data_input, subframe, order - 11, error_code);

            case 10:
                INIT_ONE_COEFF(data_input, subframe, order - 10, error_code);

            case 9:
                INIT_ONE_COEFF(data_input, subframe, order - 9, error_code);

            case 8:
                INIT_ONE_COEFF(data_input, subframe, order - 8, error_code);

            case 7:
                INIT_ONE_COEFF(data_input, subframe, order - 7, error_code);

            case 6:
                INIT_ONE_COEFF(data_input, subframe, order - 6, error_code);

            case 5:
                INIT_ONE_COEFF(data_input, subframe, order - 5, error_code);

            case 4:
                INIT_ONE_COEFF(data_input, subframe, order - 4, error_code);

            case 3:
                INIT_ONE_COEFF(data_input, subframe, order - 3, error_code);

            case 2:
                INIT_ONE_COEFF(data_input, subframe, order - 2, error_code);

            case 1:
                INIT_ONE_COEFF(data_input, subframe, order - 1, error_code);
        }

#undef INIT_ONE_COEFF

        if (*error_code == -1)
            return 0;

        residual_coding_method = get_shifted_bits(data_input, 2, error_code);
        if (*error_code == -1)
            return 0;

        switch (residual_coding_method) {
            case 0:
                subframe->residual_info.rice_parameter_size = 4;
                break;

            case 1:
                subframe->residual_info.rice_parameter_size = 5;
                break;

            default:
                *error_code = -1;
                return 0;
        }

        subframe->residual_info.rice_parameter = 0;
        subframe->residual_info.has_escape_code = 0;
        subframe->residual_info.escape_bits_per_sample = 0;
        subframe->residual_info.remaining_nb_samples = 0;
        subframe->residual_info.is_first_partition = 1;

        subframe->residual_info.partition_order = get_shifted_bits(data_input, 4, error_code);
        if (*error_code == -1)
            return 0;

        subframe->has_parameters = 1;
    }

    if (crt_sample < order) {
        switch (order - crt_sample) {
            case 32:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, 0, crt_sample, error_code);

            case 31:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 30:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 29:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 28:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 27:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 26:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 25:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 24:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 23:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 22:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 21:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 20:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 19:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 18:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 17:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 16:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 15:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 14:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 13:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 12:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 11:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 10:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 9:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 8:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 7:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 6:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 5:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 4:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 3:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 2:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);

            case 1:
                OUTPUT_ONE_WARMUP(data_output, frame_info, subframe, channel_nb, crt_sample, crt_sample, error_code);
                goto decode_lpc_subframe;
        }

        if (*error_code == -1)
            return 0;

        SKIP_INPUT(data_input, frame_info, subframe, channel_nb, order, order, error_code);
        return crt_sample;
    } else {
        *error_code = put_shifted_bits(data_output, subframe->next_out->value << subframe->wasted_bits_per_sample,
                                       subframe->bits_per_sample, frame_info->channel_assignement, channel_nb);
        if (*error_code == -1)
            return 0;

        ++crt_sample;
        subframe->next_out = subframe->next_out->next;
    }

    decode_lpc_subframe:;
    for (; crt_sample < frame_info->block_size; ++crt_sample) {
        DECODE_TYPE value = 0;
        previous_value_t *crt = subframe->next_out;

#define ADD_TO_VALUE(subframe, crt, index, value) \
    do { \
        (value) += (subframe)->coeffs[(index)] * (crt)->value; \
    } while(0)

        switch (order) {
            case 32:
                ADD_TO_VALUE(subframe, crt, 31, value);
                crt = crt->next;

            case 31:
                ADD_TO_VALUE(subframe, crt, 30, value);
                crt = crt->next;

            case 30:
                ADD_TO_VALUE(subframe, crt, 29, value);
                crt = crt->next;

            case 29:
                ADD_TO_VALUE(subframe, crt, 28, value);
                crt = crt->next;

            case 28:
                ADD_TO_VALUE(subframe, crt, 27, value);
                crt = crt->next;

            case 27:
                ADD_TO_VALUE(subframe, crt, 26, value);
                crt = crt->next;

            case 26:
                ADD_TO_VALUE(subframe, crt, 25, value);
                crt = crt->next;

            case 25:
                ADD_TO_VALUE(subframe, crt, 24, value);
                crt = crt->next;

            case 24:
                ADD_TO_VALUE(subframe, crt, 23, value);
                crt = crt->next;

            case 23:
                ADD_TO_VALUE(subframe, crt, 22, value);
                crt = crt->next;

            case 22:
                ADD_TO_VALUE(subframe, crt, 21, value);
                crt = crt->next;

            case 21:
                ADD_TO_VALUE(subframe, crt, 20, value);
                crt = crt->next;

            case 20:
                ADD_TO_VALUE(subframe, crt, 19, value);
                crt = crt->next;

            case 19:
                ADD_TO_VALUE(subframe, crt, 18, value);
                crt = crt->next;

            case 18:
                ADD_TO_VALUE(subframe, crt, 17, value);
                crt = crt->next;

            case 17:
                ADD_TO_VALUE(subframe, crt, 16, value);
                crt = crt->next;

            case 16:
                ADD_TO_VALUE(subframe, crt, 15, value);
                crt = crt->next;

            case 15:
                ADD_TO_VALUE(subframe, crt, 14, value);
                crt = crt->next;

            case 14:
                ADD_TO_VALUE(subframe, crt, 13, value);
                crt = crt->next;

            case 13:
                ADD_TO_VALUE(subframe, crt, 12, value);
                crt = crt->next;

            case 12:
                ADD_TO_VALUE(subframe, crt, 11, value);
                crt = crt->next;

            case 11:
                ADD_TO_VALUE(subframe, crt, 10, value);
                crt = crt->next;

            case 10:
                ADD_TO_VALUE(subframe, crt, 9, value);
                crt = crt->next;

            case 9:
                ADD_TO_VALUE(subframe, crt, 8, value);
                crt = crt->next;

            case 8:
                ADD_TO_VALUE(subframe, crt, 7, value);
                crt = crt->next;

            case 7:
                ADD_TO_VALUE(subframe, crt, 6, value);
                crt = crt->next;

            case 6:
                ADD_TO_VALUE(subframe, crt, 5, value);
                crt = crt->next;

            case 5:
                ADD_TO_VALUE(subframe, crt, 4, value);
                crt = crt->next;

            case 4:
                ADD_TO_VALUE(subframe, crt, 3, value);
                crt = crt->next;

            case 3:
                ADD_TO_VALUE(subframe, crt, 2, value);
                crt = crt->next;

            case 2:
                ADD_TO_VALUE(subframe, crt, 1, value);
                crt = crt->next;

            case 1:
                ADD_TO_VALUE(subframe, crt, 0, value);
        }

        if (subframe->lpc_shift < 0)
            value = value << (uint8_t) (-subframe->lpc_shift);
        else {
            if (value < 0)
                value = -(((-value) + (dividers[subframe->lpc_shift] - 1)) >> subframe->lpc_shift);
            else
                value = value >> subframe->lpc_shift;
        }

        value += get_next_rice_residual(data_input, &(subframe->residual_info), frame_info->block_size, order,
                                        error_code);
        if (*error_code == -1)
            return 0;

        subframe->next_out->value = value;

        *error_code = put_shifted_bits(data_output, value << subframe->wasted_bits_per_sample,
                                       subframe->bits_per_sample, frame_info->channel_assignement, channel_nb);
        if (*error_code == -1)
            return 0;

        if (*error_code == 0) {
            SKIP_INPUT(data_input, frame_info, subframe, channel_nb, order, crt_sample + 1, error_code);
            return crt_sample;
        }

        subframe->next_out = subframe->next_out->next;
    }

    return frame_info->block_size;

}

#undef INIT_ONE_WARMUP
#undef OUTPUT_ONE_WARMUP
#undef SKIP_INPUT

static int decode_frame(data_input_t *data_input, data_output_t *data_output, uint8_t bits_per_sample,
                        uint8_t nb_channels) {

    int error_code = 0;
    uint8_t channel_nb = 0;
    frame_info_t frame_info;
#ifdef STEREO_ONLY
    uint16_t crt_samples[2] = {0};
#else
    uint16_t crt_samples[8] = {0};
#endif
    uint16_t nb_read_samples = 0;

    frame_info.nb_channels = nb_channels;

    error_code = read_frame_header(data_input, bits_per_sample, &frame_info);
    if (error_code == -1)
        return -1;

    if (error_code == 0)
        return 0;

#ifdef STEREO_ONLY
    if((frame_info.channel_assignement != LEFT_RIGHT) && (frame_info.channel_assignement != LEFT_SIDE) && (frame_info.channel_assignement != RIGHT_SIDE) && (frame_info.channel_assignement != MID_SIDE)) {
        fprintf(stderr, "Stereo only is supported\n");
        return -1;
    }
#endif

    /* Initialize some per subframe values */
    for (; channel_nb < nb_channels; ++channel_nb) {
        frame_info.subframes_info[channel_nb].has_parameters = 0;
        frame_info.subframes_info[channel_nb].data_input_position = -1;
    }

    do {
        int nb_bits_to_write = 0;

        data_output->starting_position = data_output->position;
        data_output->starting_shift = data_output->shift;

        for (channel_nb = 0; channel_nb < nb_channels; ++channel_nb) {
            if (crt_samples[channel_nb] == 0) {
                if (read_subframe_header(data_input, frame_info.subframes_info + channel_nb) == -1)
                    return -1;
                if ((((frame_info.channel_assignement == LEFT_SIDE) || (frame_info.channel_assignement == MID_SIDE)) &&
                     (channel_nb == 1)) || ((frame_info.channel_assignement == RIGHT_SIDE) && (channel_nb == 0)))
                    frame_info.subframes_info[channel_nb].bits_per_sample = frame_info.bits_per_sample + 1;
                else
                    frame_info.subframes_info[channel_nb].bits_per_sample = frame_info.bits_per_sample;
            } else if (frame_info.subframes_info[channel_nb].type != SUBFRAME_CONSTANT) {

                if (skip_to_position(data_input, frame_info.subframes_info[channel_nb].data_input_position) == -1)
                    return -1;
                data_input->shift = frame_info.subframes_info[channel_nb].data_input_shift;
            }

            if (frame_info.subframes_info[channel_nb].type == SUBFRAME_CONSTANT)
                crt_samples[channel_nb] = decode_constant(data_input, data_output, &frame_info, channel_nb,
                                                          crt_samples[channel_nb], &error_code);
            else if (frame_info.subframes_info[channel_nb].type == SUBFRAME_VERBATIM)
                crt_samples[channel_nb] = decode_verbatim(data_input, data_output, &frame_info, channel_nb,
                                                          crt_samples[channel_nb], &error_code);
            else if ((SUBFRAME_FIXED_LOW <= frame_info.subframes_info[channel_nb].type) &&
                     (frame_info.subframes_info[channel_nb].type <= SUBFRAME_FIXED_HIGH))
                crt_samples[channel_nb] = decode_fixed(data_input, data_output, &frame_info, channel_nb,
                                                       crt_samples[channel_nb], &error_code);
            else if ((SUBFRAME_LPC_LOW <= frame_info.subframes_info[channel_nb].type) &&
                     (frame_info.subframes_info[channel_nb].type <= SUBFRAME_LPC_HIGH))
                crt_samples[channel_nb] = decode_lpc(data_input, data_output, &frame_info, channel_nb,
                                                     crt_samples[channel_nb], &error_code);
            else {
                fprintf(stderr, "Invalid subframe type\n");
                return -1;
            }

            if (error_code == -1)
                return -1;

#ifdef STEREO_ONLY
            if(channel_nb == 0) {
#else
            if ((channel_nb + 1) < nb_channels) {
#endif
                switch (frame_info.bits_per_sample) {
#ifdef DECODE_8_BITS
                    case 8:
                        data_output->position = data_output->starting_position + (channel_nb + 1);
                        break;
#endif
#ifdef DECODE_12_BITS
                    case 12:
                        data_output->position = data_output->starting_position + (channel_nb + 1);
                        if(data_output->shift == 4) {
                            data_output->shift = 0;
                            ++data_output->position;
                        } else {
                            data_output->shift = 4;
                        }
                        break;
#endif
#ifdef DECODE_16_BITS
                    case 16:
                        data_output->position = data_output->starting_position + ((channel_nb + 1) * 2);
                        break;
#endif
#ifdef DECODE_20_BITS
                    case 20:
                        data_output->position = data_output->starting_position + ((channel_nb + 1) * 2);
                        if(data_output->shift == 4) {
                            data_output->shift = 0;
                            ++data_output->position;
                        } else {
                            data_output->shift = 4;
                        }
                        break;
#endif
#ifdef DECODE_24_BITS
                    case 24:
                        data_output->position = data_output->starting_position + ((channel_nb + 1) * 3);
                        break;
#endif
#ifdef DECODE_32_BITS
                    case 32:
                        data_output->position = data_output->starting_position + ((channel_nb + 1) * 4);
#endif
                }
            }
        }

        nb_read_samples = crt_samples[0] - nb_read_samples;

        nb_bits_to_write = nb_read_samples * nb_channels * frame_info.bits_per_sample + data_output->starting_shift;
        dump_buffer(data_output, nb_bits_to_write);

        nb_read_samples = crt_samples[0];
    } while (crt_samples[0] < frame_info.block_size);

    if ((frame_info.subframes_info[channel_nb - 1].type == SUBFRAME_CONSTANT) &&
        (frame_info.subframes_info[channel_nb - 1].data_input_position != -1)) {
        if (skip_to_position(data_input, frame_info.subframes_info[channel_nb - 1].data_input_position) == -1)
            return -1;
        data_input->shift = frame_info.subframes_info[channel_nb - 1].data_input_shift;
    }

    if (data_input->shift != 0) {
        data_input->shift = 0;
        ++data_input->position;
    }

    get_shifted_bits(data_input, 16, &error_code);
    if (error_code == -1)
        return -1;

    return 1;

}

int decode_flac_metadata(data_input_t *data_input, stream_info_t *stream_info) {

    if (get_flac_stream_info(data_input, stream_info) == -1)
        return -1;

    if (skip_metadata(data_input) == -1)
        return -1;

    return 0;

}

int decode_flac_data(data_input_t *data_input, data_output_t *data_output, uint8_t bits_per_sample,
                     uint8_t nb_channels) {

    int error_code = 0;

    while ((error_code = decode_frame(data_input, data_output, bits_per_sample, nb_channels)) > 0);

    if (error_code == -1)
        return -1;

    return 0;

}
