module.exports = (app) ->
  app.get '/c/search', (req, res) ->
    res.send {
      name : 'Maverick\'s Kitchen',
      imageUrl : 'https://www.google.com/intl/en_com/images/srpr/logo3w.png',
      address : {
        street : '200 University Avenue',
        city : 'Waterloo',
        state : 'ON',
        country : 'Canada',
        zipcode : 'L4S1T4'
      }
    }
