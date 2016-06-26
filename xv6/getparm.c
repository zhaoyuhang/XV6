#include <stdlib.h>
#include <stdio.h>
#include <getopt.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "flacdec.h"

int main(int argc, char *argv[]) {

    int opt = -1;
    struct option options[] = {
            {"unsigned",   no_argument,       NULL, 'u'},
            {"big-endian", no_argument,       NULL, 'b'},
            {"input-size", required_argument, NULL, 's'},
            {NULL,         0,                 NULL, 0}
    };
    data_input_t data_input = {0};
    stream_info_t stream_info = {0};

    int input_buffer_size = 1024;
    int input_fd = -1;
    uint8_t is_little_endian = 1;
    uint8_t is_signed = 1;
    char output_buffer[64];

    while ((opt = getopt_long(argc, argv, "iq", options, NULL)) > -1)
        switch (opt) {
            case 'b':
                is_little_endian = 0;
                break;

            case 'u':
                is_signed = 0;
                break;

            case 's':
                input_buffer_size = atoi(optarg);
                if (input_buffer_size < 42) {
                    fprintf(stderr, "The size of the input should be greater than 42 bytes\n");
                    return EXIT_FAILURE;
                }
                break;

            case '?':
                fprintf(stderr, "Usage: %s [--big-endian] [--unsigned] [--input-size bytes] flac_file\n", argv[0]);
                return EXIT_FAILURE;
        }

    if (optind == argc) {
        fprintf(stderr, "Usage: %s [--big-endian] [--unsigned] [--input-size bytes] flac_file\n", argv[0]);
        return EXIT_FAILURE;
    }

    if ((input_fd = open(argv[optind++], O_RDONLY)) == -1) {
        perror("An error occured while opening the flac file");
        return EXIT_FAILURE;
    }

    if (init_data_input_from_fd(&data_input, input_fd, input_buffer_size) == -1)
        return EXIT_FAILURE;

    if (decode_flac_metadata(&data_input, &stream_info) == -1)
        return EXIT_FAILURE;

    switch (stream_info.bits_per_sample) {
        case 8:
        case 16:
        case 32:
            snprintf(output_buffer, sizeof(output_buffer), "-f %c%u_%cE -c %u -r %u", is_signed ? 'S' : 'U',
                     stream_info.bits_per_sample, is_little_endian ? 'L' : 'B', stream_info.nb_channels,
                     stream_info.sample_rate);
            break;

        case 24:
            snprintf(output_buffer, sizeof(output_buffer), "-f %c24_3%cE -c %u -r %u", is_signed ? 'S' : 'U',
                     is_little_endian ? 'L' : 'B', stream_info.nb_channels, stream_info.sample_rate);
            break;

        default:
            return EXIT_FAILURE;
    }

    printf("%s", output_buffer);

    free(data_input.buffer);
    close(input_fd);

    return EXIT_SUCCESS;
}
