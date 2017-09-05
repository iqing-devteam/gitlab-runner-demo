FROM ubuntu:14.04

COPY /sources.list /etc/apt/sources.list

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y vim htop curl git git-man libedit2 liberror-perl libx11-6 \
    libx11-data libxau6 libxcb1 libxdmcp6 libxext6 libxmuu1 openssh-client patch \
    rsync xauth && \
    curl -sSL https://get.docker.com/ | sh

RUN  curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh \
     | sudo bash && \
     apt-get install -y gitlab-ci-multi-runner

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY /config.toml /etc/gitlab-runner/config.toml # 需要关注的重点

CMD ["gitlab-runner", "run", "ruby-tester"]
