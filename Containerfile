ARG BASE_IMAGE
ARG BASE_IMAGE_NAME

FROM scratch AS ctx

COPY system_files /files
COPY build_files /build_files

FROM ${BASE_IMAGE}

# Set BASE_IMAGE environment variable for build scripts
ENV BASE_IMAGE=${BASE_IMAGE_NAME}

RUN --mount=type=tmpfs,dst=/tmp \
  --mount=type=bind,from=ctx,source=/,target=/run/context \
  mkdir -p /var/roothome && \
  /run/context/build_files/build.sh
