For this exercise, modify the `docker` command in [run.sh](run.sh) to meet the following
requirements:
* Find running containers with the label `org` containing the value `cscc`
* You should use the `docker ps` command (hint: see the filter information in the [docker ps documentation](https://docs.docker.com/engine/reference/commandline/ps/))
* You should only output the numeric container IDs (not the rest of the normal pretty print output)

To verify your answer, you can run `./test.sh`.  If everything works you will see `SUCCESS!!!`
printed to your terminal.
