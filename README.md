# dockerstep
This project provides a Dockerized environment for experimenting with GNUstep and customizing the layout to resemble macOS, particularly focusing on implementing a global menu. GNUstep is an open-source implementation of the NeXTSTEP and macOS development environment.

![Screenshot_20240115_201929](https://github.com/pkgdemon/dockerstep/assets/4109732/85f80b20-fb79-49c2-abd3-86da280f2eba)

## Background

GNUstep is a free software implementation of the Cocoa (formerly NeXTSTEP/OpenStep) APIs, as well as a development environment in its own right. It provides an object-oriented framework for developing desktop applications on Unix-like operating systems. Originating from the NeXTSTEP operating system, it shares similarities with the macOS development environment.

NeXTSTEP, the precursor to macOS, was the operating system developed by NeXT, Inc., a company founded by Steve Jobs in the late 1980s. NeXTSTEP laid the foundation for many concepts and technologies that eventually became integral to macOS. When Apple acquired NeXT in 1997, NeXTSTEP's influence became evident in the subsequent development of macOS.

Key aspects that NeXTSTEP introduced and influenced in macOS development include:

- **Objective-C:** NeXTSTEP popularized the use of Objective-C as the primary programming language, a tradition continued in macOS development.

- **Cocoa Frameworks:** Many of the Cocoa frameworks, such as AppKit and Foundation, were initially part of NeXTSTEP and were later refined and integrated into macOS.

- **Interface Builder:** NeXTSTEP introduced Interface Builder, a graphical user interface design tool. It evolved into the Interface Builder used in macOS development.

This project allows developers to explore the roots of macOS development by providing a customizable GNUstep environment that reflects the heritage of NeXTSTEP.

#### Requirements

* docker (The user must also be a member of docker group)
* xhost
* xwayland

Getting the image:
```
docker pull ghcr.io/pkgdemon/dockerstep:main
```

Running as regular user:

```
./dockerstep
```
