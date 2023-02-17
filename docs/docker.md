# Docker

Collection of useful Docker commands and utilities. Learn all about Docker, from the basics to advanced topics.

## Automated Install Script

=== "Debian"

    ```bash
    apt update; \
    apt install curl; \
    curl -fsSL https://get.docker.com -o get-docker.sh; \
    chmod +x ./get-docker.sh; \
    ./get-docker.sh
    ```

=== "Ubuntu"

    ```bash
    sudo apt update; \
    sudo apt install curl; \
    curl -fsSL https://get.docker.com -o get-docker.sh; \
    chmod +x ./get-docker.sh; \
    sudo ./get-docker.sh
    ```

=== "Fedora/RHEL"

    ```bash
    sudo dnf update; \
    sudo dnf install curl; \
    curl -fsSL https://get.docker.com -o get-docker.sh; \
    chmod +x ./get-docker.sh; \
    sudo ./get-docker.sh
    ```

=== "Arch"

    ```bash
    sudo pacman -Syu; \
    sudo pacman -S docker; \
    sudo systemctl start docker; \
    sudo systemctl enable docker
    sudo usermod -aG docker $USER
    ```

=== "Alpine"

    ```bash
    echo "http://ftp.halifax.rwth-aachen.de/alpine/v3.16/main" >> /etc/apk/repositories; \
    echo "http://ftp.halifax.rwth-aachen.de/alpine/v3.16/community" >> /etc/apk/repositories; \
    apk update; \
    apk add docker docker-cli-compose; \
    rc-update add dockerboot; \
    service docker start
    ```

## Composerize

Convert Docker run commands to `docker-compose.yml` files

- Third-party host: [https://www.composerize.com/](https://www.composerize.com/)
- My backup: [https://github.com/tyleraharrison/composerize](https://github.com/tyleraharrison/composerize)
