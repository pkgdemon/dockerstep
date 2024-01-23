# Use Debian Bookworm as the base image
FROM debian:bookworm-slim

# Add contrib repository to sources.list
RUN echo "deb http://deb.debian.org/debian/ bookworm contrib" >> /etc/apt/sources.list

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y git gnustep gnustep-devel gnustep-make libcss-dev libx11-dev make ttf-mscorefonts-installer sudo zsh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a sudoers file with wheel group permissions
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel

# Copy GNUStep defaults
COPY GNUstep /etc/skel/GNUstep

# Set the environment variable to avoid GNUstep warnings
ENV GS_INSTALLATION_DOMAIN GSDomainLocal

# Clone the git repo for rik theme
RUN git clone https://github.com/pkgdemon/gnustep-theme-rik.git

# Clone the git repo for browser
RUN git clone https://github.com/anthonyc-r/netsurf-gnustep

# Build and install the rik theme
WORKDIR /gnustep-theme-rik
RUN export GNUSTEP_MAKEFILES="/usr/lib/GNUstep/Makefiles" && \
    . /usr/lib/GNUstep/Makefiles/GNUstep.sh && \
    gnustep-config --objc-flags > Makefile && \
    gmake && \
    gmake install

# Build and install browser
WORKDIR /netsurf-gnustep
RUN export GNUSTEP_MAKEFILES="/usr/lib/GNUstep/Makefiles" && \
    . /usr/lib/GNUstep/Makefiles/GNUstep.sh && \
    gmake TARGET=gnustep && \
    gmake install

# Expose the default GNUstep port (per GWorkspace configuration)
EXPOSE 8080

# Copy the entry point script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Set the entry point
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
