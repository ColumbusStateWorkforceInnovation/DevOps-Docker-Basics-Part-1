# Docker images

One of the frequently used CLI commands is `docker images`.  Try to run it now.  You should see output similar to:
```
[jschmersal1@WFIL011 01-docker-images]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
```

This means you have no docker images locally.  Let's download an image.  To do so, we will use the `docker pull` command.  Run this: `docker pull postgres`.  After running this, run `docker images` and you should see something similar to:
```
[jschmersal1@WFIL011 01-docker-images]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
postgres            latest              4b52913b0a3a        4 days ago          313MB
```

The output tells you the image `postgres` is available locally, the version of the image is the one tagged `latest`, and it gives you a unique Image Id for that particular version of postgres.  This image happened to be created 4 days ago and is 313 MB in size.


You frequently won't run `docker pull` to download your images before running them, as `docker run` will automatically download the specified image if you don't already have it locally.  To see this, run `docker run --rm ubuntu echo hello world`.  Here's the output I see when running it (note the image being downloaded, then `hello world` spitting out at the end):
```
[jschmersal1@WFIL011 01-docker-images]$ docker run ubuntu echo hello world
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
3ff22d22a855: Pull complete 
e7cb79d19722: Pull complete 
323d0d660b6a: Pull complete 
b7f616834fd0: Pull complete 
Digest: sha256:5d1d5407f353843ecf8b16524bc5565aa332e9e6a1297c73a92d3e754b8a636d
Status: Downloaded newer image for ubuntu:latest
hello world
```

Occasionally you will need to clean up your local images.  To do so, use the `docker rmi` command.  For example, run `docker rmi ubuntu` now.  Here's my output:
```
[jschmersal1@WFIL011 01-docker-images]$ docker rmi ubuntu
Untagged: ubuntu:latest
Untagged: ubuntu@sha256:5d1d5407f353843ecf8b16524bc5565aa332e9e6a1297c73a92d3e754b8a636d
Deleted: sha256:1e4467b07108685c38297025797890f0492c4ec509212e2e4b4822d367fe6bc8
Deleted: sha256:7515ee845913c8df9826c988341a09e0240e291c66bdc436a067e070d7910a1f
Deleted: sha256:50ebe6a0675f1ed7ca499a2ec7d8cc993d495dd66ca1035c218ec5efcb6fbb8c
Deleted: sha256:2515e0ecfb82d58c004c4b53fcf9230d9eca8d0f5f823c20172be01eec587ccb
Deleted: sha256:ce30112909569cead47eac188789d0cf95924b166405aa4b71fb500d6e4ae08d
```

Now run `docker images` and see the change:
```
[jschmersal1@WFIL011 01-docker-images]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
postgres            latest              4b52913b0a3a        4 days ago          313MB
```

It is frequently handy to get a machine readable listing of your docker image IDs only.  To do so run `docker images -q`.  This is the "quiet" listing, showing only the id:

```
[jschmersal1@WFIL011 01-docker-images]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
postgres            latest              4b52913b0a3a        4 days ago          313MB
[jschmersal1@WFIL011 01-docker-images]$ docker images -q
4b52913b0a3a
```

If you ever find yourself wanting to blow away all of your images, you can run `docker rmi -f $(docker images -aq)`:

```
[jschmersal1@WFIL011 01-docker-images]$ docker rmi $(docker images -q)
Untagged: postgres:latest
Untagged: postgres@sha256:6a250876f8dec6fcf1f3ce255da7c02cb74c48bab023e073fd4f3125d496a275
Deleted: sha256:4b52913b0a3acca859b8c12dd4f248f1f342d869d28cf1843f9061f7d6bd5411
Deleted: sha256:d10a10623f0ee444fe072061ad202374d9e34f68320c20db8844a388a54e68e6
Deleted: sha256:f7a107d36b138f48ee10ad095447ab22690762a8e69ab66518ec7810eece3d6c
Deleted: sha256:81c3ee464a824e5732e74598932921cbdabe03ca206ade0aa467072fca1613c5
Deleted: sha256:046cbb8ad0505d50d7bf03681075b9c65bee21fa12aba6a3d336a3d6fe3337a1
Deleted: sha256:8041f0593cf2fb587c69a9c8a300a9609edac156c4f833381b3a135407e6c488
Deleted: sha256:9601c113734c4fa68dada79714639044883f34a4f6a6551a52da78351e6cc68d
Deleted: sha256:f4979d4a46b9781c23c55f2ad2a2f12cae18e248ec4744a90f2bb9ee15b96df9
Deleted: sha256:f586f94703b700ea4c60191f52c1a132f0eff1e069193925f2e3dce15fa1e4d4
Deleted: sha256:cc4c915649aa0133295ae7b6c6b9b919f82ef63565a68e8ad1a9d8651d8addf5
Deleted: sha256:2a06c42cf0a69c9d868f74eb0f4671f84d5a28c3729b7658315308135a600b33
Deleted: sha256:f4e2d03265a29b07e3c41e7a45e982dddb156b3ea6f5a26d5d0f248e9aa241ca
Deleted: sha256:ecb37f1a23dfc3a5e9b73c3f29945f2d7a7738bc7cbfc01352357aaf2ec87d08
Deleted: sha256:08f4594a1b572698948e0d573c5258bd9029c54ff9e78e353d240cc42089a06e
Deleted: sha256:95ef25a3204339de1edf47feaa00f60b5ac157a498964790c58c921494ce7ffd
[jschmersal1@WFIL011 01-docker-images]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
```
