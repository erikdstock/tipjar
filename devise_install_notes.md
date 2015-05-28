===============================================================================

Some setup you must do manually if you haven't yet:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

  4. If you are deploying on Heroku with Rails 3.2 only, you may want to set:

       config.assets.initialize_on_precompile = false

     On config/application.rb forcing your application to not access the DB
     or load models when precompiling your assets.

  5. You can copy Devise views (for customization) to your app by running:

       rails g devise:views

===============================================================================


#Lastfm Omniauth response object 
`{
   "provider": "lastfm",
   "uid": "ripuk",
   "info": {
      "nickname": "ripuk",
      "name": "David Stephens",
      "url": "http://www.last.fm/user/ripuk",
      "image": "http://userserve-ak.last.fm/serve/252/46787679.jpg",
      "country": "UK",
      "age": "31",
      "gender": "m"
   },
   "credentials": {
      "token": "abcdefghijklmnop",
      "name": "ripuk"
   },
   "extra": {
      "raw_info": {
         "name": "ripuk",
         "realname": "David Stephens",
         "image": [
            {
               "#text": "http://userserve-ak.last.fm/serve/34/46787679.jpg",
               "size": "small"
            },
            {
               "#text": "http://userserve-ak.last.fm/serve/64/46787679.jpg",
               "size": "medium"
            },
            {
               "#text": "http://userserve-ak.last.fm/serve/126/46787679.jpg",
               "size": "large"
            },
            {
               "#text": "http://userserve-ak.last.fm/serve/252/46787679.jpg",
               "size": "extralarge"
            }
         ],
         "url": "http://www.last.fm/user/ripuk",
         "id": "25400308",
         "country": "UK",
         "age": "31",
         "gender": "m",
         "subscriber": "0",
         "playcount": "11530",
         "playlists": "0",
         "bootstrap": "0",
         "registered": {
            "#text": "2009-12-30 00:53",
            "unixtime": "1262134389"
         },
         "type": "user"
      }
   }
}`