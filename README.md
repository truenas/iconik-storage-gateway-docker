
# Notice

This is an TrueNAS fork of the original iconik-storage-gateway-docker repo. It is only intended
as a staging location for docker image builds. 


# Usage examples
Build the image first:
`$ docker build -t docker_isg:latest .`

Example on how to run the image:
```
$ docker run -it \
    --env ICONIK_URL="https://app.iconik.io/" \
    --env AUTH_TOKEN="my_auth_token" \
    --env APP_ID="my_app_id" \
    --env STORAGE_ID="my_storage_id" \
    -v /mnt/my_nas:/mnt/mynas \
    -v /home/my_user/isg_local_data:/var/iconik/iconik_storage_gateway/data \
    docker_isg:latest
```

you could also use external `config.ini` instead:
```
docker run -it \
    -v /mnt/my_nas:/mnt/mynas \
    -v /home/my_user/isg_local_data:/var/iconik/iconik_storage_gateway/data \
    -v /home/my_user/isg_custom_config:/my_isg_config \
    docker_isg:latest iconik_storage_gateway --config=/my_isg_config/config.ini
```

`/home/my_user/isg_local_data` - custom preferred location on host
for the ISG local database. It is important to mount it as an external
volume in order to make local database persistent.


# docker-compose

You can also use docker compose to manage the ISG.
We have provided an example docker-compose.yaml file which can be used as a base for your configuration.
You will need to configure a storage volume in the docker-compose.yaml file to map your storage into the container,
and also add your app-id, auth-token and storage-id to the file .env

After configuring this you can bring up the ISG with the command

```
docker compose up -d
```

This will start the ISG process in a detached container.

You can view the logs with the command

```
docker compose logs -f isg
```

# Development

To build a docker image against the latest development build of the
ISG, you can use the following command to install the package from the
development build repository.

`docker build --build-arg REPO_BASE=https://packages.iconik.io/dev/deb/ubuntu  -t docker_isg:latest .`

> [!CAUTION]
>
> Development builds of the ISG are not to be considered stable and
> should not be used in production. iconik does not provide support for
> issues arising from running development builds.
