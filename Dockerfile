# Use Debian Bookworm as the base image
FROM debian:bookworm-slim

# Add contrib repository to sources.list
RUN echo "deb http://deb.debian.org/debian/ bookworm contrib" >> /etc/apt/sources.list

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y git gnustep gnustep-devel gnustep-make make ttf-mscorefonts-installer && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy GNUStep defaults
COPY GNUstep /etc/GNUstep

# Set the environment variable to avoid GNUstep warnings
ENV GS_INSTALLATION_DOMAIN GSDomainLocal

# Expose the default GNUstep port (per GWorkspace configuration)
EXPOSE 8080

# Start GWorkspace with XWayland
CMD ["GWorkspace", "--display", ":1"]
