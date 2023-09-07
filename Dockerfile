ARG BASE_IMAGE
ARG BUILDER_IMAGE

FROM $BUILDER_IMAGE as builder
WORKDIR /go/src/DataDog/container-object-storage-interface-provisioner-sidecar
ADD . .
ENV GOFLAGS="-buildvcs=false"
RUN make build

FROM $BASE_IMAGE
LABEL maintainers="Compute"
LABEL description="Object Storage Sidecar"
COPY --from=builder /go/src/DataDog/container-object-storage-interface-provisioner-sidecar/bin/objectstorage-sidecar objectstorage-sidecar
ENTRYPOINT ["/objectstorage-sidecar"]
