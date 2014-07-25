express = require 'express'
http = require 'http'
assert = require 'assert'
fs = require 'fs'
file = __filename.replace('/server.coffee', '') + '/history.json'
history = {}

fs.readFile file, 'utf8', (err, data) ->
  if err
    console.log 'Error: ' + err
    return
 
  history = JSON.parse data
  console.log history

write_history = () ->
  console.log "writing to file"
  console.log history
  fs.writeFile file, JSON.stringify(history, null, 4), (err) ->
      if err
        console.log err
      else
        console.log "JSON saved to #{file}"

# setInterval write_balls, 10000

setup_server = () ->

  app = express()

  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + '/public')

  app.get '/api', (req, res) ->
    console.log "-- someones lookin at /"
    res.send history

  port = process.env.HTTP_PORT || 8080
  app.listen port
  console.log "Listening on port #{port}"

setup_server()
