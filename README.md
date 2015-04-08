# CinchControlPanel

This gem adds an angular.js and websockets based web control panel for the [Cinch](https://github.com/cinchrb/cinch) bot framework

## Installation
NOTE: NOT PUBLISHED YET. THIS IS NOT A COMPLETE BUILD
Add this line to your application's Gemfile:

```ruby
gem 'CinchControlPanel'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install CinchControlPanel

## Usage

Either call `CinchControlPanel::WebServer.run!` in your ruby code or setup a rackup file

    #config.ru
    require 'CinchControlPanel'
    run CinchControlPanel::WebServer

and call it via `rackup -p 4567`

## Contributing

1. Fork it ( https://github.com/mdelaossa/CinchControlPanel/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
