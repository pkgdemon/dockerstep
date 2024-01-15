# Use Debian Bookworm as the base image
FROM debian:bookworm-slim

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y git gnustep gnustep-devel gnustep-make make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone the git repo for rik theme
RUN git clone https://github.com/AlessandroSangiuliano/rik.theme.git

# Set the environment variable to avoid GNUstep warnings
ENV GS_INSTALLATION_DOMAIN GSDomainLocal

# Build and install the rik theme
WORKDIR /rik.theme
RUN export GNUSTEP_MAKEFILES="/usr/lib/GNUstep/Makefiles" && \
    . /usr/lib/GNUstep/Makefiles/GNUstep.sh && \
    gnustep-config --objc-flags > Makefile && \
    gmake && \
    gmake install

# Expose the default GNUstep port (per GWorkspace configuration)
EXPOSE 8080

# Start GWorkspace with XWayland
CMD ["GWorkspace", "--display", ":1"]