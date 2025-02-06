ARG FROM_IMG="${FROM_IMG:-quay.io/okd/centos-stream-coreos-9}"
ARG FROM_TAG="${FROM_TAG:-4.18-x86_64}"

FROM ${FROM_IMG}:${FROM_TAG}

# Install/remove packages to make an image with resembles Fedora CoreOS
COPY build.sh /tmp/build.sh
RUN chmod +x /tmp/build.sh &&\
    /tmp/build.sh && \
    dnf clean all && \
    ostree container commit

# Just gotta get this green!
RUN bootc container lint