require 'open3'
require 'sinatra'

def volume
  stdin, stdout, wait_thr = Open3.popen2("osascript", "-e" "output volume of (get volume settings)")
  stdout.read.chomp
end

set :bind, '0.0.0.0'

get '/' do
  @volume = volume
  erb :index
end

get '/volume' do
  volume
end

put '/volume' do
  begin
    value = Integer(params['volume'])
    halt 400, "Invalid value" if value < 0 or value > 100
  rescue ArgumentError
    halt 400, "Not an integer"
  end

  stdin, stdout, wait_thr = Open3.popen2("osascript", "-e" "set volume output volume #{value}")
  204
end
