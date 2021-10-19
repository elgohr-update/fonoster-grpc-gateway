FROM golang AS builder
LABEL maintainer="Pedro Sanders <psanders@fonoster.com>"

ENV PROTOC_VERSION=3.18.1
ENV PROTOC_ZIP=protoc-$PROTOC_VERSION-linux-x86_64.zip
ENV BRANCH=master
ENV PROTOS=" \
  common.proto \
  users.proto \  
  agents.proto \
  domains.proto \
  providers.proto \
  numbers.proto \
  callmanager.proto \
  auth.proto \
  funcs.proto \
  secrets.proto \
  storage.proto"

WORKDIR /protos
COPY protos /protos


ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/core/src/protos/common.proto /protos/common.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/users/src/protos/users.proto /protos/users.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/agents/src/protos/agents.proto /protos/agents.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/domains/src/protos/domains.proto /protos/domains.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/providers/src/protos/providers.proto /protos/providers.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/numbers/src/protos/numbers.proto /protos/numbers.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/callmanager/src/protos/callmanager.proto /protos/callmanager.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/auth/src/protos/auth.proto /protos/auth.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/funcs/src/protos/funcs.proto /protos/funcs.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/secrets/src/protos/secrets.proto /protos/secrets.proto
ADD https://raw.githubusercontent.com/fonoster/fonos/$BRANCH/mods/storage/src/protos/storage.proto /protos/storage.proto

RUN apt-get update && apt-get install -y unzip
RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v$PROTOC_VERSION/$PROTOC_ZIP \
  && unzip -o $PROTOC_ZIP -d /usr/local bin/protoc \
  && unzip -o $PROTOC_ZIP -d /usr/local 'include/*' \
  && rm -f $PROTOC_ZIP \
  && go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest \
  && protoc -I /protos $PROTOS --openapiv2_out=disable_default_errors=true,openapi_naming_strategy=simple,allow_merge=true,logtostderr=true:.

# Second stage
FROM fonoster/base
COPY --from=builder /protos/apidocs.swagger.json /swagger.json
COPY --from=builder /protos /protos
COPY . /scripts

RUN ./install.sh \
  && apk add curl
WORKDIR /protos
RUN chown -R fonos /protos
USER fonos

HEALTHCHECK CMD curl --fail  http://localhost:8080/api/ping || exit 1
