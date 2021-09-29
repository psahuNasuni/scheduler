FROM alpine:3.7
ENV TERRAFORM_VERSION=1.0.7

RUN apk update && \
    apk add curl jq bash ca-certificates git openssl unzip wget vim && \
    cd /tmp && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin 
RUN apk -v --update add python3 py3-pip groff less mailcap && \
    pip3 install --upgrade pip && \
    pip3 install awscli && \
    apk -v --purge del py3-pip && \
    rm /var/cache/apk/*
# RUN mkdir /root/.aws/
VOLUME /root/.aws
VOLUME /project
# COPY nac-es /project
WORKDIR /project
# ENTRYPOINT ["/bin/sh/", runContainer.sh]
CMD /bin/bash/ runContainer.sh
