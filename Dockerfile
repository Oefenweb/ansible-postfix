FROM ubuntu:18.04
MAINTAINER Mischa ter Smitten <mtersmitten@oefenweb.nl>

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# python
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y python3-minimal python3-dev curl && \
  apt-get clean
RUN curl -sL https://bootstrap.pypa.io/pip/3.6/get-pip.py | python3 -
RUN rm -rf $HOME/.cache

# ansible
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3-apt && \
  apt-get clean
RUN pip3 install ansible==2.10.7
RUN rm -rf $HOME/.cache

# provision
COPY . /etc/ansible/roles/ansible-role
WORKDIR /etc/ansible/roles/ansible-role
RUN ansible-playbook -i tests/inventory tests/test.yml --connection=local
