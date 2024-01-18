# dockerstep
This project provides a Dockerized environment for experimenting with GNUstep and customizing the layout to resemble macOS.

![Screenshot_20240115_201929](https://github.com/pkgdemon/dockerstep/assets/4109732/85f80b20-fb79-49c2-abd3-86da280f2eba)

## Background

GNUstep is a free software implementation of the Cocoa (formerly NeXTSTEP/OpenStep) APIs, as well as a development environment in its own right. It provides an object-oriented framework for developing desktop applications on Unix-like operating systems. Originating from the NeXTSTEP operating system, it shares similarities with the macOS development environment.

NeXTSTEP, the precursor to macOS, was the operating system developed by NeXT, Inc., a company founded by Steve Jobs in the late 1980s. NeXTSTEP laid the foundation for many concepts and technologies that eventually became integral to macOS. When Apple acquired NeXT in 1997, NeXTSTEP's influence became evident in the subsequent development of macOS.

Key aspects that NeXTSTEP introduced and influenced in macOS development include:

- **Objective-C:** NeXTSTEP popularized the use of Objective-C as the primary programming language, a tradition continued in macOS development.

- **Cocoa Frameworks:** Many of the Cocoa frameworks, such as AppKit and Foundation, were initially part of NeXTSTEP and were later refined and integrated into macOS.

- **Interface Builder:** NeXTSTEP introduced Interface Builder, a graphical user interface design tool. It evolved into the Interface Builder used in macOS development.

This project allows developers to explore the roots of macOS development by providing a customizable GNUstep environment that reflects the heritage of NeXTSTEP.

## Requirements

1. **Linux:** This setup is expected to work seamlessly on Linux.  For Windows users utilizing WSL (Windows Subsystem for Linux), this setup should also work given the compatibility of Docker with WSL.
On macOS, the setup should work as long as Docker and Xorg requirements can be met through macports or XQuartz package.

2. **Docker:** The project relies on Docker for containerization. Ensure that Docker is installed on your machine. You can download Docker [here](https://www.docker.com/get-started).

**Note:** Additionally, the user running the project must be a member of the `docker` group to have the necessary permissions to interact with Docker without using `sudo`.

```
# Add the user to the docker group (replace 'username' with your actual username)
sudo usermod -aG docker username
```

3. **xhost:** The xhost command is used to control access to the X server for X Window System applications. It is essential for launching the GUI from the container on the host without the need for the complex setup of xauthority.
   
```
# Install xhost (replace the package manager command and package name based on your distribution)
sudo apt-get install x11-xserver-utils  # For Debian/Ubuntu
```

## Pulling the Docker Image and Launching the GUI

To use the `dockerstep` command to pull the image and launch the GUI, follow these steps:

1. **Pull the Docker Image:**
   
   Pull the Docker image from the repository using the following command:
   ```
   docker pull ghcr.io/pkgdemon/dockerstep:main
   ```

2. **Clone this repository to your local machine:**

   Run the following command to clone this respositry to your machine:
   ```
   git clone https://github.com/pkgdemon/docker.git
   ```

3. **Running as regular user:**

   Enter the directory and execute the ***dockerstep*** command to run the Docker container and launch the GUI. It is important to run this command as your user so your home directory can be shared with the container:

   ```
   cd dockerstep && dockerstep
   ```
