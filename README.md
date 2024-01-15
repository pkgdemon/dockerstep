# dockerstep
GNUstep running in docker for experimentation

#### Requirements

* docker (The user must also be a member of docker group)
* xhost
* xwayland

Building:
```
docker build -t dockerstep .
```
Before running the container we need use allow X forwarding

```
xhost +
````

Running as regular user:

```
./dockerstep
```
