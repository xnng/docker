const express = require('express')

const app = express()

app.get('/', (req, res) => {
  res.json({
    code: 0,
    message: 'express is running',
    env: process.env.NODE_ENV,
    process: process.pid
  })
})

app.listen(8000)
