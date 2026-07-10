FROM docker.io/library/debian:trixie-slim
WORKDIR app
RUN apt-get update && apt-get -y install \
   ssh \
   sshfs
RUN useradd -m accessuser
COPY ./files/container_startup_script.sh /app/container_startup_script.sh
COPY ./files/sshd_config /etc/ssh/sshd_config
CMD ["/bin/bash", "/app/container_startup_script.sh"]
