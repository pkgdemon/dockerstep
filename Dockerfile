# Use Debian Bookworm as the base image
FROM debian:bookworm-slim

# Install necessary dependencies for X11 and Wayland with XWayland
RUN apt-get update && \
    apt-get install -y git gmake gnustep gnustep-devel && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone the git repo for rik theme
RUN git clone https://github.com/pkgdemon/gnustep-theme-rik.git

# Build the rik theme and install it
RUN cd gnustep-theme-rik && gmake && gmake install

# Set the environment variable to avoid GNUstep warnings
ENV GS_INSTALLATION_DOMAIN GSDomainLocal

# Expose the default GNUstep port (per GWorkspace configuration)
EXPOSE 8080

# Start GWorkspace with XWayland
CMD ["GWorkspace", "--display", ":1"]