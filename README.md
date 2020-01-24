# caddy

## Build Caddy from source and serve a "Hello world!" page using Docker. 

**build.sh**

- Disables Caddy Telemetry. 
- Uses Ubuntu as base Docker image for build. 
- builds the "caddy" binary and copy it to the current working directory on the host (to distribute to other folks / push to artifact repository). 


**run.sh** 
- builds and runs a container which listens on port 8080 for http:// and returns "Hello world!". 
- uses Alpine as base Docker image for serving the "Hello world!" application, 


- You can pin to a particular Caddy commit with passing the caddy version to each script
- Both scripts Use latest stable version of Go from https://golang.org/dl/ to compile.

## prerequisite
 - Docker version 19.03.5
