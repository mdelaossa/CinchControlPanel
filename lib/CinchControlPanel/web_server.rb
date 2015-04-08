module CinchControlPanel

  require 'sinatra'
  require 'sinatra/assetpack'
  require 'sinatra-websocket'

  require 'tilt/erb'
  require 'sass'

  require 'json'

  class WebServer < Sinatra::Base
    configure :production, :development do
      enable :logging
    end

    set :root, File.dirname(__FILE__)
    #set :environment, :production #TODO: Switch when done

    set :sockets, []
    set :bots, []

    register Sinatra::AssetPack

    assets do
      serve '/scripts', from: 'scripts'
      serve '/scripts/vendor', from: 'bower_components'
      serve '/styles', from: 'styles'

      js :application, %w(/scripts/vendor/angular/angular.min.js
                          /scripts/vendor/angular-route/angular-route.min.js
                          /scripts/vendor/angular-websocket/angular-websocket.min.js
                          /scripts/vendor/ng-websocket/ng-websocket.js
                          /scripts/vendor/angular-scroll-glue/src/scrollglue.js
                          /scripts/*.js)
      css :application, ['/styles/*.css']

      js_compression :jsmin
      css_compression :sass
    end

    get '/' do
      erb :index
    end

    #This route servers the log over a websocket connection
    get '/websocket' do
      if !request.websocket?
        halt 403, 'WebSockets only'
      else
        request.websocket do |ws|
          ws.onopen do
            settings.sockets << ws
            EM.next_tick { ws.send WebSocketMessage.new('log',CinchControlPanel::LoggerOutput.instance).to_s } #send the entire history right away
          end
        end
      end
    end

    #get '/*' do #TODO: Enable for HTML5MODE
      #erb :index
    #end
  end
end