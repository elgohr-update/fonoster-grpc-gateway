FROM golang AS builder
LABEL maintainer="Pedro Sanders <psanders@fonoster.com>"

ENV PROTOS="common.proto agents.proto domains.proto"
ENV PROTOC_ZIP=protoc-3.14.0-linux-x86_64.zip
ENV BRANCH=dev

WORKDIR /protos
COPY protos /protos

ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/core/src/protos/common.proto /protos/common.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/domains/src/protos/domains.proto /protos/domains.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/agents/src/protos/agents.proto /protos/agents.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/providers/src/protos/providers.proto /protos/providers.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/numbers/src/protos/numbers.proto /protos/numbers.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/callmanager/src/protos/callmanager.proto /protos/callmanager.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/auth/src/protos/auth.proto /protos/auth.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/funcs/src/protos/funcs.proto /protos/funcs.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/secrets/src/protos/secrets.proto /protos/secrets.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/storage/src/protos/storage.proto /protos/storage.proto

RUN apt-get update && apt-get install -y unzip
RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/$PROTOC_ZIP \
  && unzip -o $PROTOC_ZIP -d /usr/local bin/protoc \
  && unzip -o $PROTOC_ZIP -d /usr/local 'include/*' \
  && rm -f $PROTOC_ZIP \
  && go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest \
  && protoc -I /protos $PROTOS --openapiv2_out=allow_merge=true,logtostderr=true:.

# Second stage
FROM fonoster/base
COPY --from=builder /protos/apidocs.swagger.json /swagger.json
COPY --from=builder /protos /protos
COPY . /scripts

RUN ./install.sh
WORKDIR /protos
RUN chown -R fonos /protos
USER fonos

EXPOSE 8080
