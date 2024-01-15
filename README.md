# dockerstep
GNUstep running in docker for experimentation

Building:
```
docker build -t gnustep .
```

Running as specific user:

```
docker run -it --rm \
    -e DISPLAY=$DISPLAY \
    --net=host \
    -u $(id -u jmaloney):$(id -g jmaloney) \
    -v /home/jmaloney:/home/jmaloney \
    gnustep
```
