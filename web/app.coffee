express    = require('express')
property   = require('./lib/property')
config     = require('./config')

app = module.exports = express.createServer()
app.NODE_ENV = global.process.env.NODE_ENV || 'development'

public_dir = __dirname + '/public'


app.configure () ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.set 'view options'

  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()

  app.use express.session
    secret : config.SESSION_SECRET
    cookie : { maxAge  : config.SESSION_MAX_AGE }

  app.use require('stylus').middleware
    src      : __dirname + '/public'
    compress : app.NODE_ENV == 'production'
  app.use express.static(__dirname + '/public')

  app.dynamicHelpers
    req         : (req) -> req
    title       : ()    -> property.create()
    cssIncludes : ()    -> property.create([])
    jsIncludes  : ()    -> property.create([])

  app.use app.router

app.configure 'development', () ->
  app.use express.errorHandler { dumpExceptions: true, showStack: true }

app.configure 'production', () ->
  app.use express.errorHandler()

require(__dirname + '/controllers/search')(app)

app.all '*', (req, res) ->
  res.render '404', { status : 404, layout : false }

app.error (err, req, res, next) ->
  if err instanceof NotFound
    res.render '404', { status : 404, layout : false }
  else
    next err

if not module.parent
  app.listen(global.process.env.PORT || config.SERVER_PORT)
  console.log "Express server listening on port %d in %s mode", app.address().port, app.NODE_ENV
