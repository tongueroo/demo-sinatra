require "sinatra/base"

class SinatraApp < Sinatra::Base
  get "/" do
    query_params = request.query_string
    formatted_params = query_params.empty? ? "" : "?" + query_params
    puts "#{Time.now} - GET /#{formatted_params}"
    erb :index
  end
end
