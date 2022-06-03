#!/usr/bin/env node
const grpcGateway = require('./index.js')
const path = require('path')
const fs = require('fs')
const cors = require('cors')
const express = require('express')
const bodyParser = require('body-parser')
const swaggerUi = require("swagger-ui-express")
const swaggerDocument = fs.existsSync("/swagger.json")
  ? require('/swagger.json')
  : require('./swagger.json')

const app = express()

app.use(cors())
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))

const grpcAddr = process.env.APISERVER_ENDPOINT || "localhost:50051"

const protosDir = process.env.PROTOS_DIR || "/protos"
// Must ignore common.proto as it will be imported
const protosFiles = fs.readdirSync(protosDir)
  .filter(el => el !== "common.proto" && path.extname(el) === '.proto')

// load the proxy on / URL
const debug = process.env.DEBUG === "true"
app.use('/api', grpcGateway(protosFiles, grpcAddr, void(0) , debug, protosDir))

app.use("/api/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));

app.get("/api/ping", (req, res) => res.send("pong"));

// Keep the default port if running on docker (to avoid healthcheck failure)
const port = process.env.PORT || 8080

app.listen(port, () => {
  console.log(`Listening on 0.0.0.0 @ ${port}`)
  console.log(`docs at http://localhost:${port}/api/api-docs`)
  console.log(`ping at http://localhost:${port}/api/ping`)
})
