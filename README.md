# dockerstep
GNUstep running in docker for experimentation

#### Requirements

* docker
* xhost
* xwayland

Building:
```
docker build -t gnustep .
```
Before running the container we need use allow X forwarding

```
xhost +
````

Running as specific user:

```
docker run -it --rm \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -u $(id -u jmaloney):$(id -g jmaloney) \
    your-image-name
```
