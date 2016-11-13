Note to get the output folder shared and working on Windows 10 you need to go to Docker Settings -> Shared Drives -> share the drive this repo is cloned to.

: make the image
docker build .

: ubuntu
docker build . -f Ubuntu.Dockerfile

: start it
docker run -d -P --name test 5b215becde8d

: show which ports are open, if nothing shows up then there was an error during startup
docker port test

: Shell
docker run -it 5b215becde8d /bin/bash


: get to the bash in the composed container
docker exec -it cppsp_cppsp_1 /bin/bash