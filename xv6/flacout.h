#include <stdint.h>
#include "flacdec.h"

#ifndef OUTPUT_H
#define OUTPUT_H

struct data_output_t;

typedef int(*dump_func_t)(struct data_output_t* data_output, int nb_bits);

typedef struct data_output_t {
    dump_func_t dump_func;
    uint8_t* buffer;
    int size;
    int write_size;
    int starting_position;
    uint8_t starting_shift;
    int position;
    uint8_t shift;
    uint8_t is_little_endian;
    uint8_t is_signed;
} data_output_t;

int init_data_output_to_fd(data_output_t* data_output, int fd, int buffer_size, uint8_t is_little_endian, uint8_t is_signed, uint8_t can_pause);

static inline DECODE_TYPE convert_to_signed(DECODE_UTYPE value, uint8_t size) {

#ifdef DECODE_TYPE_16_BITS
    return value & (((DECODE_UTYPE)1) << (size - 1)) ? (((DECODE_UTYPE)0xFFFFu) << size) | value : value;
#elif defined DECODE_TYPE_32_BITS
    return value & (((DECODE_UTYPE)1) << (size - 1)) ? (((DECODE_UTYPE)0xFFFFFFFFu) << size) | value : value;
#elif defined DECODE_TYPE_64_BITS
    return value & (((DECODE_UTYPE)1) << (size - 1)) ? (((DECODE_UTYPE)0xFFFFFFFFFFFFFFFFull) << size) | value : value;
#else
#error "Should not happen but kinda did."
#endif

}

static inline int dump_buffer(data_output_t* data_output, int nb_bytes) {
    return data_output->dump_func(data_output, nb_bytes);
}

int put_shifted_bits(data_output_t* data_output, DECODE_UTYPE sample, uint8_t sample_size, uint8_t channel_assignement, uint8_t channel_nb);

#endif
