https  = require 'https'
config = require '../config'

module.exports = (app) ->
  FOURSQUARE_API = 'api.foursquare.com'
  app.get '/c/search', (req, res) ->
    options =
      host : FOURSQUARE_API
      path : "/v2/venues/search?ll=#{'43.480926,-80.537664'}" +
             "&query=#{'donuts'}&client_id=#{config.FOURSQUARE_ID}" +
             "&client_secret=#{config.FOURSQUARE_SECRET}&v=20120107"
    https.get options, (response) ->
      message = ''
      response.on 'data', (chunk) ->
        message += chunk
      response.on 'end', () ->
        res.send JSON.parse(message)
