require 'timecop'
require 'simplecov'
require 'webmock/rspec'
require 'hidemyass'
require 'pry'

WebMock.disable_net_connect!(allow: 'codeclimate.com')
WebMock.stub_request(:get, /(incloak|hidester).com/).to_return body: '[]'

SimpleCov.start do
  add_filter '/spec'
  add_filter '/lib/extensions'
end

Dir['lib/**/*.rb'].each { |f| require_relative "../#{f}" }
