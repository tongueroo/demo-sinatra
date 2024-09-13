require "sinatra/base"
require "socket"

class SinatraApp < Sinatra::Base
  get "/" do
    query_params = request.query_string
    formatted_params = query_params.empty? ? "" : "?" + query_params
    client_ip = request.ip
    request_host = request.host
    server_hostname = Socket.gethostname
    puts "#{Time.now} - #{client_ip} - #{request_host} - #{server_hostname} -GET /#{formatted_params}"

    # Print X-Forwarded-* headers
    puts "X-Forwarded-Host: #{request.env["HTTP_X_FORWARDED_HOST"]}"
    puts "X-Forwarded-For: #{request.env["HTTP_X_FORWARDED_FOR"]}"
    puts "X-Forwarded-Proto: #{request.env["HTTP_X_FORWARDED_PROTO"]}"
    puts "X-Forwarded-Port: #{request.env["HTTP_X_FORWARDED_PORT"]}"
    puts "X-Real-IP: #{request.env["HTTP_X_REAL_IP"]}"
    puts "Server Hostname: #{server_hostname}"

    erb :index
  end
end
