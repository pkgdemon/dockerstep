# dockerstep
GNUstep running in docker for experimentation

![Screenshot_20240115_201929](https://github.com/pkgdemon/dockerstep/assets/4109732/85f80b20-fb79-49c2-abd3-86da280f2eba)

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
