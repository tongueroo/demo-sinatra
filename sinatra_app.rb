require "sinatra/base"

class SinatraApp < Sinatra::Base
  get "/" do
    puts "#{Time.now} - GET /"
    erb :index
  end
end
