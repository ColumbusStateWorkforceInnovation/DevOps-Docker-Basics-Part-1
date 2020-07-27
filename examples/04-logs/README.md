# Docker Logs

Inevitably when you start a service running in docker containers, you will need to see the logs of that service for troubleshooting.  In fact, frequently those logs are shipped off to some kind of log aggregation service (e.g. the [ELK stack](https://www.elastic.co/what-is/elk-stack)).

To view your container's logs, you use the `docker logs` command.

## Example
For this example, let's start httpd running in the background, listening on port 8080:
`docker run --name apache --rm -d -p 8080:80 httpd:2.4`

Now, navigate your browser to http://localhost:8080 and click the refresh button a couple times, then the hard refresh button a few times (`<ctrl>-r` does the trick).  Now let's check out the logs:

```
[jschmersal1@WFIL011 examples]$ docker logs apache
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message
[Mon Jul 27 20:30:59.823881 2020] [mpm_event:notice] [pid 1:tid 139666078205056] AH00489: Apache/2.4.43 (Unix) configured -- resuming normal operations
[Mon Jul 27 20:30:59.825308 2020] [core:notice] [pid 1:tid 139666078205056] AH00094: Command line: 'httpd -D FOREGROUND'
172.17.0.1 - - [27/Jul/2020:20:31:40 +0000] "GET / HTTP/1.1" 200 45
172.17.0.1 - - [27/Jul/2020:20:31:44 +0000] "GET / HTTP/1.1" 304 -
172.17.0.1 - - [27/Jul/2020:20:31:45 +0000] "GET / HTTP/1.1" 304 -
172.17.0.1 - - [27/Jul/2020:20:32:03 +0000] "GET / HTTP/1.1" 200 45
172.17.0.1 - - [27/Jul/2020:20:32:03 +0000] "GET /favicon.ico HTTP/1.1" 404 196
172.17.0.1 - - [27/Jul/2020:20:32:06 +0000] "GET / HTTP/1.1" 200 45
172.17.0.1 - - [27/Jul/2020:20:32:06 +0000] "GET /favicon.ico HTTP/1.1" 404 196
```

Note that I had an initial "GET" of the web server root that returned a `200` status code (OK) along with 45 bytes of content (`172.17.0.1 - - [27/Jul/2020:20:31:40 +0000] "GET / HTTP/1.1" 200 45`).  This was followed by a couple `304` responses - those are just that the content wasn't modified.  Then you see more HTTP `200` requests corresponding to the hard refreshes.

In a later unit we will go into more detail on troubleshooting and docker, where we will explore more log options.
