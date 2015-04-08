require 'require_all'
require "CinchControlPanel/version"
require "cinch"
require "CinchControlPanel/monkey_patches"
require 'CinchControlPanel/logger/web_logger'
require 'CinchControlPanel/logger/logger_output'
require 'CinchControlPanel/web_socket_message'

require_rel 'CinchControlPanel/controllers/*.rb'

require "CinchControlPanel/web_server"

module CinchControlPanel

end