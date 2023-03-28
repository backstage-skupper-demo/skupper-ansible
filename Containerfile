FROM registry.access.redhat.com/ubi8/ubi

RUN yum install -y python3 openssh-clients
RUN pip3 install --upgrade pip \
    && pip3 install ansible hvac \
    && ansible-galaxy collection install skupper.network
RUN ansible-galaxy collection install community.hashi_vault
RUN curl -LO https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz \
    && tar -xvzf openshift-client-linux.tar.gz \
    && mv oc kubectl /usr/local/bin
RUN curl -LO https://github.com/skupperproject/skupper/releases/download/1.3.0/skupper-cli-1.3.0-linux-amd64.tgz \
    && tar -xvzf skupper-cli-1.3.0-linux-amd64.tgz \
    && mv skupper /usr/local/bin

COPY retrieve-tokens.yaml site-creation.yaml ./
