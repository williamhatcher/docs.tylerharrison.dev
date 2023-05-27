# NextCloud

## NextCloud All-In-One Docker Compose with ONLYOFFICE
```yml
version: "3.8"

volumes:
  nextcloud_aio_mastercontainer:
    name: nextcloud_aio_mastercontainer # This line is not allowed to be changed
  onlyoffice-logs:
    name: nextcloud_aio_onlyoffice_logs
  onlyoffice-data:
    name: nextcloud_aio_onlyoffice_data

services:
  nextcloud:
    image: nextcloud/all-in-one:latest # Must be changed to 'nextcloud/all-in-one:latest-arm64' when used with an arm64 CPU
    restart: always
    container_name: nextcloud-aio-mastercontainer # This line is not allowed to be changed
    volumes:
      - nextcloud_aio_mastercontainer:/mnt/docker-aio-config # This line is not allowed to be changed
      - /var/run/docker.sock:/var/run/docker.sock:ro # May be changed on macOS, Windows or docker rootless. See the applicable documentation. If adjusting, don't forget to also set 'DOCKER_SOCKET_PATH'!
    ports:
      # - 80:80 # Can be removed when running behind a reverse proxy. See https://github.com/nextcloud/all-in-one/blob/main/reverse-proxy.md
      - 8080:8080
      # - 8443:8443 # Can be removed when running behind a reverse proxy. See https://github.com/nextcloud/all-in-one/blob/main/reverse-proxy.md
    environment: # Is needed when using any of the options below
      - APACHE_PORT=11000 # Is needed when running behind a reverse proxy. See https://github.com/nextcloud/all-in-one/blob/main/reverse-proxy.md
      # - APACHE_IP_BINDING=127.0.0.1 # Should be set when running behind a reverse proxy that is running on the same host. See https://github.com/nextcloud/all-in-one/blob/main/reverse-proxy.md
      # - COLLABORA_SECCOMP_DISABLED=false # Setting this to true allows to disable Collabora's Seccomp feature. See https://github.com/nextcloud/all-in-one#how-to-disable-collaboras-seccomp-feature
      # - DOCKER_SOCKET_PATH=/var/run/docker.sock # Needs to be specified if the docker socket on the host is not located in the default '/var/run/docker.sock'. Otherwise mastercontainer updates will fail. For macos it needs to be '/var/run/docker.sock'
      # - DISABLE_BACKUP_SECTION=false # Setting this to true allows to hide the backup section in the AIO interface.
      # - NEXTCLOUD_DATADIR=/mnt/ncdata # Allows to set the host directory for Nextcloud's datadir. See https://github.com/nextcloud/all-in-one#how-to-change-the-default-location-of-nextclouds-datadir
      # - NEXTCLOUD_MOUNT=/mnt/ # Allows the Nextcloud container to access the chosen directory on the host. See https://github.com/nextcloud/all-in-one#how-to-allow-the-nextcloud-container-to-access-directories-on-the-host
      - NEXTCLOUD_UPLOAD_LIMIT=100G # Can be adjusted if you need more. See https://github.com/nextcloud/all-in-one#how-to-adjust-the-upload-limit-for-nextcloud
      # - NEXTCLOUD_MAX_TIME=3600 # Can be adjusted if you need more. See https://github.com/nextcloud/all-in-one#how-to-adjust-the-max-execution-time-for-nextcloud
      - NEXTCLOUD_MEMORY_LIMIT=4096M # Can be adjusted if you need more. See https://github.com/nextcloud/all-in-one#how-to-adjust-the-php-memory-limit-for-nextcloud
      # - NEXTCLOUD_TRUSTED_CACERTS_DIR=/path/to/my/cacerts # CA certificates in this directory will be trusted by the OS of the nexcloud container (Useful e.g. for LDAPS) See See https://github.com/nextcloud/all-in-one#how-to-trust-user-defiend-certification-authorities-ca
      - NEXTCLOUD_STARTUP_APPS=deck twofactor_totp tasks calendar contacts onlyoffice # Allows to modify the Nextcloud apps that are installed on starting AIO the first time. See https://github.com/nextcloud/all-in-one#how-to-change-the-nextcloud-apps-that-are-installed-on-the-first-startup
      - NEXTCLOUD_ADDITIONAL_APKS=aria2 imagemagick # This allows to add additional packages to the Nextcloud container permanently. Default is imagemagick but can be overwritten by modifying this value. See https://github.com/nextcloud/all-in-one#how-to-add-os-packages-permanently-to-the-nextcloud-container
      # - NEXTCLOUD_ADDITIONAL_PHP_EXTENSIONS=imagick # This allows to add additional php extensions to the Nextcloud container permanently. Default is imagick but can be overwritten by modifying this value. See https://github.com/nextcloud/all-in-one#how-to-add-php-extensions-permanently-to-the-nextcloud-container
      # - NEXTCLOUD_ENABLE_DRI_DEVICE=true # This allows to enable the /dev/dri device in the Nextcloud container which is needed for hardware-transcoding. See https://github.com/nextcloud/all-in-one#how-to-enable-hardware-transcoding-for-nextcloud
      # - TALK_PORT=3478 # This allows to adjust the port that the talk container is using.

  onlyoffice:
    image: onlyoffice/documentserver-ee
    container_name: onlyoffice-documentserver-ee
    restart: always
    volumes:
      - onlyoffice-data:/var/www/onlyoffice/Data
      - onlyoffice-logs:/var/log/onlyoffice
    ports:
      - 8081:80
      - 7443:443
```

Note: you will need to add a certificate to onlyoffice-data/certs/onlyoffice.key and .crt