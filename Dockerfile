# Use Debian Bookworm as the base image
FROM debian:bookworm-slim

# Install necessary build dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    clang \
    cmake \
    git \
    libcairo2-dev \
    libcups2-dev \
    libffi-dev \
    libflite1 \
    libgif-dev \
    libgl1-mesa-dev \
    libglade2-dev \
    libgnutls28-dev \
    libicns-dev \
    libjpeg62-turbo-dev \
    libmujs-dev \
    libnotify-dev \
    libpango1.0-dev \
    libpocketsphinx-dev \
    libpng-dev \
    libreadline-dev \
    libsndfile1-dev \
    libtiff5-dev \
    libwrap0-dev \
    libx11-dev \
    libxi-dev \
    libxext-dev \
    libxmu-dev \
    libxslt1-dev \
    libxml2-dev \
    libxslt1-dev \
    libxt-dev \
    libxtst-dev \
    ninja-build \
    sudo \
    x11proto-core-dev \
    x11proto-xext-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone the GNUstep-related repositories
RUN git clone --depth 1 https://github.com/gnustep/tools-make.git /gnustep-src/tools-make
RUN git clone --depth 1 https://github.com/gnustep/libobjc2.git /gnustep-src/libobjc2
RUN git clone --depth 1 https://github.com/gnustep/libs-base.git gnustep-src/libs-base
RUN git clone --depth 1 https://github.com/gnustep/libs-gui.git /gnustep-src/libs-gui
RUN git clone --depth 1 https://github.com/gnustep/libs-back.git /gnustep-src/libs-back
RUN git clone --depth 1 https://github.com/gnustep/apps-gworkspace.git /gnustep-src/apps-gworkspace
RUN git clone --depth 1 https://github.com/gnustep/apps-systempreferences.git /gnustep-src/apps-systempreferences

# Build and install gnustep-make
RUN cd /gnustep-src/tools-make && \
    ./configure \
    --with-thread-lib=-pthread \
    --prefix="/" \
    --with-layout=gnustep \
    --with-config-file=/etc/GNUstep.conf \
    --enable-objc-nonfragile-abi \
    --enable-native-objc-exceptions \
    --with-library-combo=ng-gnu-gnu && \
    gmake install

# Build and install libobjc2
RUN . /System/Library/Makefiles/GNUstep.sh && \
    export GNUSTEP_INSTALLATION_DOMAIN=SYSTEM && \
    cd /gnustep-src/libobjc2/ && \
    mkdir Build && \
    cd Build && \
    cmake .. \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ && \
    ninja install

# Build gnustep-base
RUN  . /System/Library/Makefiles/GNUstep.sh && \
    export GNUSTEP_INSTALLATION_DOMAIN=SYSTEM && \
    cd /gnustep-src/libs-base && \
    ./configure && \
    gmake && \
    gmake install

# Build gnustep-gui
RUN . /System/Library/Makefiles/GNUstep.sh && \
    export GNUSTEP_INSTALLATION_DOMAIN=SYSTEM && \
    cd /gnustep-src/libs-gui && \
    ./configure && \
    gmake && \
    gmake install

# Build gnustep-back
RUN . /System/Library/Makefiles/GNUstep.sh && \
    export GNUSTEP_INSTALLATION_DOMAIN=SYSTEM && \
    cd /gnustep-src/libs-back && \
    ./configure && \
    gmake && \
    gmake install

# Build GWorkspace
RUN . /System/Library/Makefiles/GNUstep.sh && \
    export GNUSTEP_INSTALLATION_DOMAIN=SYSTEM && \
    cd /gnustep-src/apps-gworkspace && \
    ./configure && \
    gmake && \
    gmake install

# Build SystemPreferences
RUN . /System/Library/Makefiles/GNUstep.sh && \
    export GNUSTEP_INSTALLATION_DOMAIN=SYSTEM && \
    cd /gnustep-src/apps-systempreferences && \
    gmake && \
    gmake install

# Cleanup GNUstep sources
RUN rm -rf /gnustep-src

# Create a sudoers file with wheel group permissions
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel

# Expose the default GNUstep port (per GWorkspace configuration)
EXPOSE 8080

# Copy the entry point script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Set the entry point
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
