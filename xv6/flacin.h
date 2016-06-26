#ifndef INPUT_H
#define INPUT_H

#include <stdint.h>
#include <unistd.h>

typedef struct {
    int fd;
    uint8_t *buffer;
    int size;
    int read_size;
    int position;
    uint8_t shift;
} data_input_t;

int init_data_input_from_fd(data_input_t *data_input, int fd, int buffer_size);

static inline int get_position(data_input_t *data_input) {

    return lseek(data_input->fd, 0, SEEK_CUR) - data_input->read_size + data_input->position;

}

int skip_to_position(data_input_t *data_input, int position);

int skip_nb_bits(data_input_t *data_input, int nb_bits_to_skip);

static inline int should_refill_input_buffer(data_input_t *data_input, int nb_needed_bytes) {

    return (data_input->read_size - data_input->position) < nb_needed_bytes;
}

int refill_input_buffer_at_least(data_input_t *data_input, int nb_needed_bytes);

int refill_input_buffer(data_input_t *data_input);

uint8_t get_one_shifted_bit(data_input_t *data_input, int *error_code);

#ifdef DISALLOW_64_BITS
uint32_t get_shifted_bits(data_input_t* data_input, uint8_t requested_size, int* error_code);
#else

uint64_t get_shifted_bits(data_input_t *data_input, uint8_t requested_size, int *error_code);

#endif

#endif
