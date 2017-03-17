FROM ubuntu:16.04

RUN apt-get update && apt-get install -y sudo openssh-server python
RUN mkdir -p /var/run/sshd

RUN useradd -m -d /home/docker -s /bin/bash docker
RUN echo "docker:docker" | chpasswd
RUN mkdir /home/docker/.ssh
RUN chmod 700 /home/docker/.ssh
COPY ./keys/docker_id_rsa.pub /home/docker/.ssh/authorized_keys
RUN chmod 600 /home/docker/.ssh/authorized_keys
RUN chown -R docker:docker /home/docker/.ssh

RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
