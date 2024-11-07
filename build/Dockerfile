FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest

ENV ARCH="amd64"
ENV RELEASE="bookworm"

## Add terraform
RUN curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [arch=${ARCH} signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com ${RELEASE} main" | tee /etc/apt/sources.list.d/hashicorp.list

## Add helm
RUN curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg && \
    echo "deb [arch=${ARCH} signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list

RUN apt-get update && apt-get install -y terraform \
    helm \
    pwgen \
    tldr \
    htop \
    nmon \
    mtr \
    iproute2 \
    pv

# Permit X11 forwarding using only IPv4
RUN cat >> /etc/ssh/sshd_config <<-EOF

AddressFamily inet
X11Forwarding yes
EOF

COPY script/*.sh /etc/workstation-startup.d/
RUN chmod +x /etc/workstation-startup.d/*.sh
