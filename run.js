#!/usr/bin/env node
const grpcGateway = require('./index.js')
const express = require('express')
const bodyParser = require('body-parser')
const swaggerUi = require("swagger-ui-express")
const swaggerDocument = require('/swagger.json')

const app = express()
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))

// load the proxy on / URL
app.use('/', grpcGateway(['agents.proto'], 'localhost:50052', void(0) , true, "/protos"))

app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));

const port = process.env.PORT || 8080
app.listen(port, () => {
  console.log(`Listening on http://localhost:${port}`)
})