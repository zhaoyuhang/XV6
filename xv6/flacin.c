#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#include "flacin.h"

int init_data_input_from_fd(data_input_t *data_input, int fd, int buffer_size) {

    if ((fd < 0) || (buffer_size < 42))
        return -1;

    data_input->fd = fd;

    data_input->size = buffer_size;
    data_input->buffer = (uint8_t *) malloc(sizeof(uint8_t) * data_input->size);
    if (data_input->buffer == NULL) {
        perror("An error occured while allocating the input buffer");
        return -1;
    }

    data_input->read_size = data_input->size;
    data_input->position = data_input->size;
    data_input->shift = 0;

    if (refill_input_buffer(data_input) != 1)
        return -1;

    return 0;

}

int skip_to_position(data_input_t *data_input, int position) {
    off_t crt_position = lseek(data_input->fd, 0, SEEK_CUR);
    if (position == -1) {
        perror("Error while skipping to position");
        return -1;
    }

    if ((position >= (crt_position - data_input->read_size)) && (position < crt_position)) {
        data_input->position = data_input->read_size - (crt_position - position);
        return 0;
    }

    if (lseek(data_input->fd, position, SEEK_SET) == -1) {
        perror("Error while skipping to position");
        return -1;
    }

    data_input->read_size = data_input->size;
    data_input->position = data_input->size;
    data_input->shift = 0;

    return (refill_input_buffer(data_input) > -1) ? 0 : -1;

}

int skip_nb_bits(data_input_t *data_input, int nb_bits_to_skip) {

    int nb_bytes_to_skip = (nb_bits_to_skip >> 3) + ((data_input->shift + (nb_bits_to_skip & 7)) >> 3);
    uint8_t new_shift = (data_input->shift + (nb_bits_to_skip & 7)) & 7;

    if ((data_input->position + nb_bytes_to_skip) < data_input->read_size) {
        data_input->position += nb_bytes_to_skip;
        data_input->shift = new_shift;
        return 0;
    }

    if (lseek(data_input->fd, nb_bytes_to_skip - (data_input->read_size - data_input->position), SEEK_CUR) == -1) {
        perror("Error while skipping to position");
        return -1;
    }

    data_input->read_size = data_input->size;
    data_input->position = data_input->size;
    data_input->shift = 0;

    if (refill_input_buffer(data_input) != 1)
        return -1;

    data_input->shift = new_shift;
    return 0;

}

int refill_input_buffer_at_least(data_input_t *data_input, int nb_needed_bytes) {

    int error_code = refill_input_buffer(data_input);

    if (error_code == -1)
        return -1;

    if ((error_code == 0) && (data_input->size >= nb_needed_bytes) &&
        ((data_input->read_size - data_input->position) < nb_needed_bytes)) {
        fprintf(stderr, "1: Unexpected end of file.\n");
        return -1;
    }

    return 0;

}

int refill_input_buffer(data_input_t *data_input) {

    int nb_read_bytes = 0;
    int relative_nb_read_bytes = 0;
    int total_nb_read_bytes = data_input->read_size - data_input->position;
    /* Try to read by the biggest chunk possible (might be silly though) */
    int nb_bytes_to_read = data_input->position;

    if (data_input->position > 0) {
        if (data_input->position < (data_input->read_size >> 1))
            memmove(data_input->buffer, data_input->buffer + data_input->position, total_nb_read_bytes);
        else
            memcpy(data_input->buffer, data_input->buffer + data_input->position, total_nb_read_bytes);
    }

    while ((nb_read_bytes = read(data_input->fd, data_input->buffer + total_nb_read_bytes, nb_bytes_to_read)) > 0) {
        total_nb_read_bytes += nb_read_bytes;
        if (total_nb_read_bytes == data_input->read_size) {
            data_input->position = 0;
            return 1;
        }
        nb_bytes_to_read = data_input->read_size - total_nb_read_bytes;
    }

    if (nb_read_bytes == -1) {
        perror("An error occurred while refilling the input buffer");
        return -1;
    }

    relative_nb_read_bytes = total_nb_read_bytes - (data_input->read_size - data_input->position);
    data_input->read_size = total_nb_read_bytes;
    data_input->position = 0;

    if (data_input->read_size == 0 || relative_nb_read_bytes == 0)
        return 0;

    return 1;

}

uint8_t get_one_shifted_bit(data_input_t *data_input, int *error_code) {

    if (data_input->position == data_input->read_size) if (refill_input_buffer(data_input) != 1) {
        *error_code = -1;
        return 1;   // We return 1 to exit loops.
    }

    ++data_input->shift;
    switch (data_input->shift) {
        case 1:
            return data_input->buffer[data_input->position] >> 7;
        case 2:
            return (data_input->buffer[data_input->position] >> 6) & 0x01;
        case 3:
            return (data_input->buffer[data_input->position] >> 5) & 0x01;
        case 4:
            return (data_input->buffer[data_input->position] >> 4) & 0x01;
        case 5:
            return (data_input->buffer[data_input->position] >> 3) & 0x01;
        case 6:
            return (data_input->buffer[data_input->position] >> 2) & 0x01;
        case 7:
            return (data_input->buffer[data_input->position] >> 1) & 0x01;
    }

    data_input->shift = 0;
    return data_input->buffer[data_input->position++] & 0x01;

}

#ifdef DISALLOW_64_BITS
uint32_t get_shifted_bits(data_input_t* data_input, uint8_t requested_size, int* error_code) {

    uint32_t value = 0;
#else

uint64_t get_shifted_bits(data_input_t *data_input, uint8_t requested_size, int *error_code) {

    uint64_t value = 0;
#endif

    uint8_t nb_needed_bits = (requested_size + data_input->shift);
    uint8_t nb_needed_bytes = nb_needed_bits >> 3;
    uint8_t *buffer = NULL;
    int position = 0;
    uint8_t shift = 0;

    *error_code = 0;

    if ((data_input->shift != 0) || (nb_needed_bits & 7) != 0)
        ++nb_needed_bytes;

    if ((data_input->read_size - data_input->position) < nb_needed_bytes) {
        *error_code = refill_input_buffer(data_input);

        if (*error_code == -1)
            return 0;

        if ((*error_code == 0) || ((data_input->read_size - data_input->position) < nb_needed_bytes)) {
            fprintf(stderr, "2: Unexpected end of file.\n");
            *error_code = -1;
            return 0;
        }
    }

    buffer = data_input->buffer;
    position = data_input->position;
    shift = data_input->shift;

    if ((shift == 0) && ((requested_size & 7) == 0)) {
        switch (requested_size) {
            case 8:
                return buffer[data_input->position++];

            case 16:
                value = (buffer[position] << 8) | buffer[position + 1];
                data_input->position += 2;
                return value;

            case 24:
                value = (buffer[position] << 16) | (buffer[position + 1] << 8) | buffer[position + 2];
                data_input->position += 3;
                return value;

            case 32:
                value = (buffer[position] << 24) | (buffer[position + 1] << 16) | (buffer[position + 2] << 8) |
                        buffer[position + 3];
                data_input->position += 4;
#ifndef DISALLOW_64_BITS
                return value;

            case 40:
                value = ((uint64_t) buffer[position] << 32) | (buffer[position + 1] << 24) |
                        (buffer[position + 2] << 16) | (buffer[position + 3] << 8) | buffer[position + 4];
                data_input->position += 5;
                return value;

            case 48:
                value = ((uint64_t) buffer[position] << 40) | ((uint64_t) buffer[position + 1] << 32) |
                        (buffer[position + 2] << 24) | (buffer[position + 3] << 16) | (buffer[position + 4] << 8) |
                        buffer[position + 5];
                data_input->position += 6;
                return value;

            case 56:
                value = ((uint64_t) buffer[position] << 48) | ((uint64_t) buffer[position + 1] << 40) |
                        ((uint64_t) buffer[position + 2] << 32) | (buffer[position + 3] << 24) |
                        (buffer[position + 4] << 16) | (buffer[position + 5] << 8) | buffer[position + 6];
                data_input->position += 7;
                return value;

            case 64:
                value = ((uint64_t) buffer[position] << 56) | ((uint64_t) buffer[position + 1] << 48) |
                        ((uint64_t) buffer[position + 2] << 40) | ((uint64_t) buffer[position + 3] << 32) |
                        (buffer[position + 4] << 24) | (buffer[position + 5] << 16) | (buffer[position + 6] << 8) |
                        buffer[position + 7];
                data_input->position += 8;
#endif
            default:
                *error_code = -1;
        }

        return value;
    }

    switch (nb_needed_bits) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
            value = ((buffer[position] & (0xFF >> shift)) >> (8 - nb_needed_bits));
            data_input->shift += requested_size;
            return value;

        case 8:
        case 9:
        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
        case 15:
            value = ((buffer[position] & (0xFF >> shift)) << (nb_needed_bits - 8)) |
                    (buffer[position + 1] >> (16 - nb_needed_bits));
            data_input->position += 1;
            data_input->shift = nb_needed_bits - 8;
            return value;

        case 16:
        case 17:
        case 18:
        case 19:
        case 20:
        case 21:
        case 22:
        case 23:
            value = ((buffer[position] & (0xFF >> shift)) << (nb_needed_bits - 8)) |
                    (buffer[position + 1] << (nb_needed_bits - 16)) | (buffer[position + 2] >> (24 - nb_needed_bits));
            data_input->position += 2;
            data_input->shift = nb_needed_bits - 16;
            return value;
        case 24:
        case 25:
        case 26:
        case 27:
        case 28:
        case 29:
        case 30:
        case 31:
            value = ((buffer[position] & (0xFF >> shift)) << (nb_needed_bits - 8)) |
                    (buffer[position + 1] << (nb_needed_bits - 16)) | (buffer[position + 2] << (nb_needed_bits - 24)) |
                    (buffer[position + 3] >> (32 - nb_needed_bits));
            data_input->position += 3;
            data_input->shift = nb_needed_bits - 24;
#ifndef DISALLOW_64_BITS
            return value;

        case 32:
        case 33:
        case 34:
        case 35:
        case 36:
        case 37:
        case 38:
        case 39:
            value = ((uint64_t) (buffer[position] & (0xFF >> shift)) << (nb_needed_bits - 8)) |
                    (buffer[position + 1] << (nb_needed_bits - 16)) | (buffer[position + 2] << (nb_needed_bits - 24)) |
                    (buffer[position + 3] << (nb_needed_bits - 32)) | (buffer[position + 4] >> (40 - nb_needed_bits));
            data_input->position += 4;
            data_input->shift = nb_needed_bits - 32;
            return value;

        case 40:
        case 41:
        case 42:
        case 43:
        case 44:
        case 45:
        case 46:
        case 47:
            value = ((uint64_t) (buffer[position] & (0xFF >> shift)) << (nb_needed_bits - 8)) |
                    ((uint64_t) buffer[position + 1] << (nb_needed_bits - 16)) |
                    (buffer[position + 2] << (nb_needed_bits - 24)) | (buffer[position + 3] << (nb_needed_bits - 32)) |
                    (buffer[position + 4] << (nb_needed_bits - 40)) | (buffer[position + 5] >> (48 - nb_needed_bits));
            data_input->position += 5;
            data_input->shift = nb_needed_bits - 40;
            return value;

        case 48:
        case 49:
        case 50:
        case 51:
        case 52:
        case 53:
        case 54:
        case 55:
            value = ((uint64_t) (buffer[position] & (0xFF >> shift)) << (nb_needed_bits - 8)) |
                    ((uint64_t) buffer[position + 1] << (nb_needed_bits - 16)) |
                    ((uint64_t) buffer[position + 2] << (nb_needed_bits - 24)) |
                    (buffer[position + 3] << (nb_needed_bits - 32)) | (buffer[position + 4] << (nb_needed_bits - 40)) |
                    (buffer[position + 5] << (nb_needed_bits - 48)) | (buffer[position + 6] >> (56 - nb_needed_bits));
            data_input->position += 6;
            data_input->shift = nb_needed_bits - 48;
            return value;

        case 56:
        case 57:
        case 58:
        case 59:
        case 60:
        case 61:
        case 62:
        case 63:
            value = ((uint64_t) (buffer[position] & (0xFF >> shift)) << (nb_needed_bits - 8)) |
                    ((uint64_t) buffer[position + 1] << (nb_needed_bits - 16)) |
                    ((uint64_t) buffer[position + 2] << (nb_needed_bits - 24)) |
                    ((uint64_t) buffer[position + 3] << (nb_needed_bits - 32)) |
                    (buffer[position + 4] << (nb_needed_bits - 40)) | (buffer[position + 5] << (nb_needed_bits - 48)) |
                    (buffer[position + 6] << (nb_needed_bits - 56)) | (buffer[position + 7] >> (64 - nb_needed_bits));
            data_input->position += 7;
            data_input->shift = nb_needed_bits - 56;
            return value;

        case 64:
        case 65:
        case 66:
        case 67:
        case 68:
        case 69:
        case 70:
        case 71:
            value = ((uint64_t) (buffer[position] & (0xFF >> shift)) << (nb_needed_bits - 8)) |
                    ((uint64_t) buffer[position + 1] << (nb_needed_bits - 16)) |
                    ((uint64_t) buffer[position + 2] << (nb_needed_bits - 24)) |
                    ((uint64_t) buffer[position + 3] << (nb_needed_bits - 32)) |
                    (buffer[position + 4] << (nb_needed_bits - 40)) | (buffer[position + 5] << (nb_needed_bits - 48)) |
                    (buffer[position + 6] << (nb_needed_bits - 56)) | (buffer[position + 7] << (nb_needed_bits - 64)) |
                    (buffer[position + 8] >> (72 - nb_needed_bits));
            data_input->position += 8;
            data_input->shift = nb_needed_bits - 64;
#endif
        default:
            *error_code = -1;
    }

    return value;
}
