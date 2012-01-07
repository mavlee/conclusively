module.exports = (app) ->
  app.get '/c/search', (req, res) ->
    res.send {
      'hello' : 'world'
    }
