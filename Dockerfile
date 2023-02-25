FROM ubuntu:latest AS base

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends ca-certificates apt-transport-https nginx git openssh-server

RUN echo "$(which git-shell)" >> /etc/shells
RUN rm -rf /var/www
RUN mkdir -p /git/

RUN rm -rf /etc/nginx/*
COPY src/nginx.conf /etc/nginx/

RUN adduser --home /git \
            --no-create-home \
            --shell /usr/bin/git-shell \
            --uid 1337 \
            --gecos '' \
            --ingroup www-data \
            --disabled-password git

RUN chmod -x /etc/update-motd.d/*

COPY src/authorized_keys /root/
COPY src/git_server_repos /root/
COPY src/banner /etc/banner
COPY src/entrypoint.sh /usr/bin/entrypoint.sh
COPY src/sshd_config /etc/ssh/
COPY src/gitconfig /root/gitconfig
COPY src/git-shell-commands /root/git-shell-commands

WORKDIR /git
ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
CMD [ "/usr/bin/entrypoint.sh" ]
