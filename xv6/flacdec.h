#ifndef DECODE_FLAC_H
#define DECODE_FLAC_H

#include <stdint.h>

#ifdef DISALLOW_64_BITS
#undef DECODE_32_BITS
#endif

#ifdef DECODE_32_BITS
#define DECODE_TYPE_64_BITS
#define DECODE_UTYPE uint64_t
#define DECODE_TYPE int64_t
#elif defined DECODE_16_BITS || defined DECODE_20_BITS || defined DECODE_24_BITS
#define DECODE_TYPE_32_BITS
#define DECODE_UTYPE uint32_t
#define DECODE_TYPE int32_t
#else
#define DECODE_TYPE_16_BITS
#define DECODE_UTYPE uint16_t
#define DECODE_TYPE int16_t
#endif

#include "flacin.h"
#include "flacout.h"

#define SUBFRAME_CONSTANT   0
#define SUBFRAME_VERBATIM   1
#define SUBFRAME_FIXED_LOW  8
#define SUBFRAME_FIXED_HIGH 12
#define SUBFRAME_LPC_LOW    32
#define SUBFRAME_LPC_HIGH   63

#ifndef STEREO_ONLY
#define MONO                                                      0
#endif

#define LEFT_RIGHT                                                    1

#ifndef STEREO_ONLY
#define LEFT_RIGHT_CENTER                                         2
#define F_LEFT_F_RIGHT_B_LEFT_B_RIGHT                             3
#define F_LEFT_F_RIGHT_F_CENTER_B_LEFT_B_RIGHT                    4
#define F_LEFT_F_RIGHT_F_CENTER_LFE_B_LEFT_B_RIGHT                5
#define F_LEFT_F_RIGHT_F_CENTER_LFE_B_CENTER_S_LEFT_S_RIGHT       6
#define F_LEFT_F_RIGHT_F_CENTER_LFE_B_LEFT_B_RIGHT_S_LEFT_S_RIGHT 7
#endif

#define LEFT_SIDE                                                     8
#define RIGHT_SIDE                                                    9
#define MID_SIDE                                                      10

typedef struct {
    uint16_t min_block_size;
    uint16_t max_block_size;
    uint32_t min_frame_size;
    uint32_t max_frame_size;
    uint32_t sample_rate;
    uint8_t nb_channels;
    uint8_t bits_per_sample;
#ifndef DISALLOW_64_BITS
    uint64_t nb_samples;
#endif
    uint8_t md5[16];
} stream_info_t;

int decode_flac_metadata(data_input_t *data_input, stream_info_t *stream_info);

int decode_flac_data(data_input_t *data_input, data_output_t *data_output, uint8_t bits_per_sample,
                     uint8_t nb_channels);

#endif
