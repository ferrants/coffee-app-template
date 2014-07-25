express = require 'express'
http = require 'http'
assert = require 'assert'
fs = require 'fs'

file = __filename.replace('/server.coffee', '') + '/data.json'
world = {
  data: {hits: 0}
}

fs.readFile file, 'utf8', (err, data) ->
  if err
    console.log 'Error: ' + err
    return
 
  world.data = JSON.parse data
  console.log world.data


write_data = () ->
  console.log "writing to file"
  console.log world.data
  fs.writeFile file, JSON.stringify(world.data, null, 4), (err) ->
      if err
        console.log err
      else
        console.log "JSON saved to #{file}"

setup_server = () ->

  app = express()

  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + '/public')

  app.get '/api', (req, res) ->
    console.log "-- someones lookin at /"
    world.data.hits += 1
    write_data()
    res.send {state: 'running', hits: world.data.hits}

  port = process.env.HTTP_PORT || 8080
  app.listen port
  console.log "Listening on port #{port}"

setup_server()
