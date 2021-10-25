#!/usr/bin/env sh

# Requires go an protoc-gen-openapiv2@latest
# go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest \
export PATH=$PATH:~/go/bin

grpc_tools_node_protoc \
    -I$(pwd)/protos \
    common.proto \
    projects.proto \
    users.proto \
    domains.proto \
    agents.proto \
    providers.proto \
    numbers.proto \
    callmanager.proto \
    auth.proto \
    funcs.proto \
    secrets.proto \
    storage.proto \
    --openapiv2_out=disable_default_errors=true,openapi_naming_strategy=simple,allow_merge=true,logtostderr=true:.

mv apidocs.swagger.json swagger.json

