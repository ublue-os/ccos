ARG MAJOR_VERSION="${MAJOR_VERSION:-stream9}"

FROM quay.io/centos-bootc/centos-bootc:$MAJOR_VERSION

# Install/remove packages to make an image with resembles Fedora CoreOS
COPY build.sh /tmp/build.sh
RUN chmod +x /tmp/build.sh &&\
    /tmp/build.sh && \
    dnf clean all && \
    ostree container commit

# Just gotta get this green!
RUN bootc container lint