#!/usr/bin/env node
const grpcGateway = require('./index.js')
const path = require('path')
const fs = require('fs')
const express = require('express')
const bodyParser = require('body-parser')
const swaggerUi = require("swagger-ui-express")
const swaggerDocument = require('/swagger.json')

const app = express()
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))

const grpcAddr = process.env.APISERVER_ENDPOINT || "localhost:50051"

const protosDir = process.env.PROTOS_DIR || "/protos"
// Must ignore common.proto as it will be imported
const protosFiles = fs.readdirSync(protosDir)
  .filter(el => el !== "common.proto" && path.extname(el) === '.proto')

// load the proxy on / URL
app.use('/', grpcGateway(protosFiles, grpcAddr, void(0) , true, protosDir))

app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));

app.get("/ping", (req, res) => res.send("pong"));

// Keep the default port if running on docker (to avoid healthcheck failure)
const port = process.env.PORT || 8080

app.listen(port, () => {
  console.log(`Listening on http://0.0.0.0:${port}`)
})
