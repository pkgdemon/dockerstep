# Use Debian Bookworm as the base image
FROM debian:bookworm-slim

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y git gnustep gnustep-devel gnustep-make make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone the git repo for rik theme
RUN git clone https://github.com/pkgdemon/gnustep-theme-rik.git

# Set the environment variable to avoid GNUstep warnings
ENV GS_INSTALLATION_DOMAIN GSDomainLocal

# Add the GNUstep environment variables
RUN export GNUSTEP_MAKEFILES="/usr/lib/GNUstep/Makefiles"
RUN . /usr/lib/GNUstep/Makefiles/GNUstep.sh

# Try to generate Makefile for rik theme
RUN cd /gnustep-theme-rik && gnustep-config --objc-flags > Makefile 
RUN cd /gnustep-theme-rik && gmake
RUN cd /gnustep-theme-rik && gmake install

# Expose the default GNUstep port (per GWorkspace configuration)
EXPOSE 8080

# Start GWorkspace with XWayland
CMD ["GWorkspace", "--display", ":1"]