# Docker run, start, and stop

## Docker run
You can use `docker run` to create and start your docker containers from a specified docker image in one command.  There are many options that you will frequently use to `docker run`.  Let's get started.  First, run `docker run redis`:
```
[jschmersal1@WFIL011 examples]$ docker run redis
Unable to find image 'redis:latest' locally
latest: Pulling from library/redis
6ec8c9369e08: Pull complete 
efe6cceb88f8: Pull complete 
cdb6bd1ce7c5: Pull complete 
9d80498f79fe: Pull complete 
b7cd40c9247b: Pull complete 
96403647fb55: Pull complete 
Digest: sha256:d86d6739fab2eaf590cfa51eccf1e9779677bd2502894579bcf3f80cb37b18d4
Status: Downloaded newer image for redis:latest
1:C 27 Jul 2020 15:31:12.780 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
1:C 27 Jul 2020 15:31:12.781 # Redis version=6.0.6, bits=64, commit=00000000, modified=0, pid=1, just started
1:C 27 Jul 2020 15:31:12.781 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
1:M 27 Jul 2020 15:31:12.783 * Running mode=standalone, port=6379.
1:M 27 Jul 2020 15:31:12.783 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
1:M 27 Jul 2020 15:31:12.783 # Server initialized
1:M 27 Jul 2020 15:31:12.783 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
1:M 27 Jul 2020 15:31:12.783 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
1:M 27 Jul 2020 15:31:12.783 * Ready to accept connections
```

Notice a couple things.  First, your terminal prompt didn't come back.  That's because the redis docker container is running in that terminal.  There are options (more later) to start the container but keep it running in the background so you can continue interacting with your terminal.

How can we see what's going on?  Which containers are running?

## docker ps

To see a list of containers on your system, you can use the `docker ps` command, with various options.

For now, open up a new terminal and type `docker ps`.  You'll see something like:
```
[jschmersal1@WFIL011 examples]$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
c948ee522a8f        redis               "docker-entrypoint.s…"   4 minutes ago       Up 4 minutes        6379/tcp            tender_gagarin
```

Note that a new container is running, it gives the image that it used, the command inside the docker that was run, and other status information.  In this run, since I didn't specify a name, docker chose to name this container `tender_gagarin`.

Second, when we ran `docker run redis`, it chose a particular version of the image (the one tagged `latest`).  You can specify which tag you want to run also.

Let's try to refine this a bit (you can leave your original redis running).  Try this command: `docker run --name my-redis redis:6.0.6`.  This will start a redis container with a specific version (6.0.6) and named `my-redis`:
```
[jschmersal1@WFIL011 examples]$ docker run --name my-redis redis:6.0.6
Unable to find image 'redis:6.0.6' locally
6.0.6: Pulling from library/redis
Digest: sha256:d86d6739fab2eaf590cfa51eccf1e9779677bd2502894579bcf3f80cb37b18d4
Status: Downloaded newer image for redis:6.0.6
1:C 27 Jul 2020 15:41:33.843 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
1:C 27 Jul 2020 15:41:33.843 # Redis version=6.0.6, bits=64, commit=00000000, modified=0, pid=1, just started
1:C 27 Jul 2020 15:41:33.843 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
1:M 27 Jul 2020 15:41:33.845 * Running mode=standalone, port=6379.
1:M 27 Jul 2020 15:41:33.845 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
1:M 27 Jul 2020 15:41:33.845 # Server initialized
1:M 27 Jul 2020 15:41:33.845 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
1:M 27 Jul 2020 15:41:33.845 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
1:M 27 Jul 2020 15:41:33.845 * Ready to accept connections
```

If you enter `<ctrl>-C` (the Ctrl button and the C button at the same time) in this terminal, notice that redis stops running and you are back in control of your terminal:
```
^C1:signal-handler (1595864575) Received SIGINT scheduling shutdown...
1:M 27 Jul 2020 15:42:55.796 # User requested shutdown...
1:M 27 Jul 2020 15:42:55.796 * Saving the final RDB snapshot before exiting.
1:M 27 Jul 2020 15:42:55.798 * DB saved on disk
1:M 27 Jul 2020 15:42:55.798 # Redis is now ready to exit, bye bye...
[jschmersal1@WFIL011 examples]$
```

Let's get back to that problem of the container taking over your terminal.  You can use the `-d` option to run the container in detached mode.  This makes the container run in the background and lets you still run commands in that terminal, even though the container is still running: `docker run --name my-detached-redis -d redis:6.0.6`
```
[jschmersal1@WFIL011 examples]$ docker run --name my-detached-redis -d redis:6.0.6
5cf6dfa39ec31f8435652c1d62f81ce7d690d818931a5ac5efef43f16f5b5728
[jschmersal1@WFIL011 examples]$
```

As you can see, only the container id is output to the screen.

Now my system has two redis containers running: `docker ps`
```
[jschmersal1@WFIL011 examples]$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
5cf6dfa39ec3        redis:6.0.6         "docker-entrypoint.s…"   54 seconds ago      Up 53 seconds       6379/tcp            my-detached-redis
c948ee522a8f        redis               "docker-entrypoint.s…"   15 minutes ago      Up 15 minutes       6379/tcp            tender_gagarin
```

_Side note_: Try running the last container again - `docker run --name my-detached-redis -d redis:6.0.6`.  What happened?  Why?

Let's clean up some of these running containers...

## docker stop and docker rm
To stop a running container, you use `docker stop`.  Here's how to stop the `my-detached-redis` container: `docker stop my-detached-redis`
```
[jschmersal1@WFIL011 examples]$ docker stop my-detached-redis
my-detached-redis
```

Running `docker ps` you'll see:
```
[jschmersal1@WFIL011 examples]$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
c948ee522a8f        redis               "docker-entrypoint.s…"   19 minutes ago      Up 19 minutes       6379/tcp            tender_gagarin
```

So the only running container is the original one in your terminal.  However, if you try to start the my-detached-redis container again, there's a problem:
```
[jschmersal1@WFIL011 examples]$ docker run --name my-detached-redis -d redis:6.0.6
docker: Error response from daemon: Conflict. The container name "/my-detached-redis" is already in use by container "5cf6dfa39ec31f8435652c1d62f81ce7d690d818931a5ac5efef43f16f5b5728". You have to remove (or rename) that container to be able to reuse that name.
See 'docker run --help'.
```

It says the name is already in use.  To see what's really happening, let's look at *all* of the containers, nut just the running ones:  `docker ps -a`
```
[jschmersal1@WFIL011 examples]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                         PORTS               NAMES
5cf6dfa39ec3        redis:6.0.6         "docker-entrypoint.s…"   About an hour ago   Exited (0) About an hour ago                       my-detached-redis
7dbdbcaaf12e        redis:6.0.6         "docker-entrypoint.s…"   About an hour ago   Exited (0) About an hour ago                       my-redis
c948ee522a8f        redis               "docker-entrypoint.s…"   2 hours ago         Up 2 hours                     6379/tcp            tender_gagarin
```

So my-detached-redis still exists as a container, it's just in an "exited" state.

## docker rm
If you want to get rid of a container permanently, you can use `docker rm`.  Let's delete both the my-detached-redis and my-redis containers: `docker rm my-detached-redis my-redis`
```
[jschmersal1@WFIL011 examples]$ docker rm my-detached-redis my-redis
my-detached-redis
my-redis
[jschmersal1@WFIL011 examples]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
c948ee522a8f        redis               "docker-entrypoint.s…"   2 hours ago         Up 2 hours          6379/tcp            tender_gagarin
```

If you want to blow away all of your containers, you can pass the `-f` (force) argument and a list of all of your containers to the `docker rm` command (similar to what we did for images):
```
[jschmersal1@WFIL011 examples]$ docker rm -f $(docker ps -aq)
c948ee522a8f
[jschmersal1@WFIL011 examples]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

In future lessons we'll discuss why we might not want to blow away containers (hint: they retain state).
