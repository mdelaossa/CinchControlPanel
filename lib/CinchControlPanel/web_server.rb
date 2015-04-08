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

    set :sockets, []
    set :bots, []

    get '/' do
      erb :index
    end

    #This route servers the log over a websocket connection
    get '/websocket' do
      if !request.websocket?
        halt 403, 'WebSockets only'
      else
        end
      end
    end
  end
end