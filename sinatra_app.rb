require "sinatra/base"

class SinatraApp < Sinatra::Base
  get "/" do
    query_params = request.query_string
    formatted_params = query_params.empty? ? "" : "?" + query_params
    client_ip = request.ip
    request_host = request.host
    puts "#{Time.now} - #{client_ip} - #{request_host} - GET /#{formatted_params}"

    # Print X-Forwarded-* headers
    puts "X-Forwarded-For: #{request.env["HTTP_X_FORWARDED_FOR"]}"
    puts "X-Forwarded-Host: #{request.env["HTTP_X_FORWARDED_HOST"]}"
    puts "X-Forwarded-Proto: #{request.env["HTTP_X_FORWARDED_PROTO"]}"

    erb :index
  end
end
