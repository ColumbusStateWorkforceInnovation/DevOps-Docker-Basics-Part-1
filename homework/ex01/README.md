For this exercise, modify the `docker` command in [run.sh](run.sh) to meet the following
requirements:
* Run a container using version 2.4 of the [httpd](https://hub.docker.com/_/httpd) image
* The container should be named `h1ex01`
* The container should listen for HTTP requests on port 9191
* The container should run in the background (detached)
* The container should be removed automatically when stopped

To verify your answer, you can run `./test.sh`.  If everything works you will see `SUCCESS!!!`
printed to your terminal.
