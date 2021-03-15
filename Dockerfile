FROM ubuntu:16.04
MAINTAINER Mischa ter Smitten <mtersmitten@oefenweb.nl>

# python
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y python-minimal python-dev curl && \
  apt-get clean
RUN curl -sL https://bootstrap.pypa.io/pip/2.7/get-pip.py | python -
RUN rm -rf $HOME/.cache

# ansible
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gcc libffi-dev libssl-dev && \
  apt-get clean
RUN pip install ansible==2.9.15
RUN rm -rf $HOME/.cache

# provision
COPY . /etc/ansible/roles/ansible-role
WORKDIR /etc/ansible/roles/ansible-role
RUN ansible-playbook -i tests/inventory tests/test.yml --connection=local
