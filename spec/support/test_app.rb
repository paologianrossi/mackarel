# frozen_string_literal: true
require 'sinatra/base'
require 'tilt/erb'
require 'rack'
require 'yaml'

class TestApp < Sinatra::Base
  class TestAppError < StandardError; end

  set :root, File.dirname(__FILE__)
  set :static, true
  set :raise_errors, true
  set :show_exceptions, false

  # Also check lib/capybara/spec/views/*.erb for pages not listed here

  get '/' do
    erb :index
  end

  get '/destination' do
    "Arrived"
  end

  post '/form' do
    '<pre id="results">' + params[:form].to_yaml + '</pre>'
  end

  post '/upload_empty' do
    if params[:form][:file].nil?
      'Successfully ignored empty file field.'
    else
      'Something went wrong.'
    end
  end

  post '/upload' do
    begin
      buffer = []
      buffer << "Content-type: #{params[:form][:document][:type]}"
      buffer << "File content: #{params[:form][:document][:tempfile].read}"
      buffer.join(' | ')
    rescue
      'No file uploaded'
    end
  end

  post '/upload_multiple' do
    begin
      buffer = ["#{params[:form][:multiple_documents].size}"]
      params[:form][:multiple_documents].each do |doc|
        buffer << "Content-type: #{doc[:type]}"
        buffer << "File content: #{doc[:tempfile].read}"
      end
      buffer.join(' | ')
    rescue
      'No files uploaded'
    end
  end
end

if __FILE__ == $0
  Rack::Handler::WEBrick.run TestApp, :Port => 8070
end
