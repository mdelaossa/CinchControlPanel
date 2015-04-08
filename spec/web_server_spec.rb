require 'rspec'

RSpec.describe CinchControlPanel::WebServer, type: :feature, js: true do

  it 'should serve an angular app on /' do
    visit '/'
    expect(page).to have_content("bots")
  end
end