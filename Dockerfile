# Use Debian Bookworm as the base image
FROM debian:bookworm-slim

# Create a user with UID 1000 named jmaloney
RUN useradd -u 1000 -m -d /home/jmaloney -s /bin/bash jmaloney

# Install necessary dependencies for X11 and Wayland with XWayland
RUN apt-get update && \
    apt-get install -y gnustep gnustep-devel && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the environment variable to avoid GNUstep warnings
ENV GS_INSTALLATION_DOMAIN GSDomainLocal

# Set the working directory
WORKDIR /home/jmaloney

# Set the user
USER jmaloney

# Expose the default GNUstep port (per GWorkspace configuration)
EXPOSE 8080

# Start GWorkspace with XWayland
CMD ["GWorkspace", "--display", ":1"]
