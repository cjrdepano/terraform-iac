FROM ubuntu:22.04

ARG TERRAFORM_VERSION=1.1.3
ARG TERRAGRUNT_VERSION=0.35.18
ARG TERRAFORM_LINK=https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
ARG TERRAGRUNT_LINK=https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64
ARG AWSCLI_LINK=https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
ARG BINDIR=/usr/local/bin
ARG PROXY_URL
ARG NO_PROXY
ARG TF_DIR=/opt/.terraform
ARG TF_USER=terraform
ARG TF_USER_UID=10001
ARG APT_DEPS="\
    apt-transport-https\
    apt-utils\
    bash\
    ca-certificates\
    curl\
    dnsutils\
    git\
    gnupg\
    jq\
    less\
    locales\
    nano\
    openssh-client\
    sshpass\
    tar\
    unzip\
    wget\
    python3-pip"

ENV DEBIAN_FRONTEND=noninteractive \
    TF_PLUGIN_CACHE_DIR=${TF_DIR}/cache \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    http_proxy="$PROXY_URL" \
    https_proxy="$PROXY_URL" \
    no_proxy="$NO_PROXY" \
    HTTP_PROXY="$PROXY_URL" \
    HTTPS_PROXY="$PROXY_URL" \
    NO_PROXY="$NO_PROXY"

WORKDIR /tmp

# install system utilities
RUN apt-get -yq update \
 && printf "%s\n" "${APT_DEPS}" > apt_packages.list \
 && xargs -a apt_packages.list apt-get install -yq --no-install-recommends \
 && apt-get autoremove -yqq --purge \
 && apt-get clean && rm -rf /var/lib/apt/lists/* \
 && rm apt_packages.list \
 && useradd \
    --create-home --shell /bin/bash \
    --uid ${TF_USER_UID} --user-group \
    --comment "Terraform Deployment User" \
    ${TF_USER} \
 && printf "LANG=%s\n" "${LANG}" > /etc/default/locale \
 && printf "LANGUAGE=%s\n" "${LANGUAGE}" >> /etc/default/locale \
 && locale-gen ${LANG} \
 && update-locale LANG=${LANG}

# install Terraform, Terragrunt, AWS CLI
RUN mkdir -pv ${TF_PLUGIN_CACHE_DIR} \
 && mkdir -pv ${TF_PLUGIN_CACHE_DIR}/tf_plugins \
 && wget -q ${TERRAFORM_LINK} -O terraform.zip \
 && unzip -q terraform.zip 'terraform' -d ${BINDIR}/ \
 && wget -q ${TERRAGRUNT_LINK} -O ${BINDIR}/terragrunt \
 && chmod +x ${BINDIR}/terragrunt \
 && wget -q ${AWSCLI_LINK} -O awscliv2.zip \
 && unzip -q awscliv2.zip && ./aws/install \
 && rm -rf aws* terraform*zip

# install python dependencies via requirements.txt
# COPY containers/terraform/python-requirements.txt /tmp/requirements.txt
# RUN pip install --no-cache-dir -r /tmp/requirements.txt

WORKDIR ${TF_DIR}

COPY containers/terraform/provider-plugins.tf tf_plugins/

WORKDIR ${TF_DIR}/tf_plugins

# install Terraform provider plugins
RUN terraform init \
    -no-color \
    -compact-warnings \
    -backend=false \
 && chown -R ${TF_USER_UID}:${TF_USER_UID} ${TF_DIR}

WORKDIR /tmp

RUN rm -rf ${TF_DIR}/tf_plugins

USER ${TF_USER}

# unset proxy
ENV http_proxy= \
    https_proxy= \
    no_proxy= \
    HTTP_PROXY= \
    HTTPS_PROXY= \
    NO_PROXY=

WORKDIR /home/${TF_USER}
