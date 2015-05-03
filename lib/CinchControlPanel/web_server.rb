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

    configure :development do
      set :logging, Logger::DEBUG
    end

    set :root, File.dirname(__FILE__)
    #set :environment, :production #TODO: Switch when done

    set :sockets, []
    set :bots, []

    controllers = ::CinchControlPanel::WebSocketController.descendants.each_with_object({}) do |controller, object|
      object[controller.to_s.split('::').last.to_sym] = controller.new
    end
    set :controllers, controllers

    register Sinatra::AssetPack

    assets do
      serve '/scripts', from: 'scripts'
      serve '/scripts/vendor', from: 'bower_components'
      serve '/styles/vendor', from: 'bower_components'
      serve '/styles', from: 'styles'

      js :application, %w(/scripts/vendor/angular/angular.min.js
                          /scripts/vendor/angular-route/angular-route.min.js
                          /scripts/vendor/jquery/dist/jquery.min.js
                          /scripts/vendor/ng-websocket/ng-websocket.js
                          /scripts/vendor/angular-scroll-glue/src/scrollglue.js
                          /scripts/vendor/bootstrap-sass-official/assets/javascripts/bootstrap.min.js
                          /scripts/*.js)
      css :application, %w(/styles/*.css)

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

          ws.onmessage do |msg|
            msg = WebSocketMessage.new(msg)
            logger.debug "Received: #{msg.to_s}"
            logger.debug "Calling #{msg.event.capitalize}Controller#action(#{msg.data['command']}, #{msg.data['data']})"
            result = controllers["#{msg.event.capitalize}Controller".to_sym].send('action', msg.data['command'], msg.data['data'])
            logger.debug "Sent: #{result}"
            EM.next_tick { ws.send(result) }
          end

          ws.onclose do
            settings.sockets.delete ws
          end
        end
      end
    end

    #get '/*' do #TODO: Enable for HTML5MODE
      #erb :index
    #end
  end
end