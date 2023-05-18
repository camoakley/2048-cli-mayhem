# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y libncurses5-dev make clang

## Add source code to the build stage.
ADD . /2048
WORKDIR /2048

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN make

# Creates a clean image and then moves the compiled binary to this clean image

# Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /2048/2048 /
