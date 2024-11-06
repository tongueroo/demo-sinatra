require "sinatra/base"
require "socket"

class SinatraApp < Sinatra::Base
  get "/" do
    # Print X-Forwarded-* headers
    # puts "X-Forwarded-Host: #{request.env["HTTP_X_FORWARDED_HOST"].inspect}"
    # puts "X-Forwarded-For: #{request.env["HTTP_X_FORWARDED_FOR"].inspect}"
    # puts "X-Forwarded-Proto: #{request.env["HTTP_X_FORWARDED_PROTO"].inspect}"
    # puts "X-Forwarded-Port: #{request.env["HTTP_X_FORWARDED_PORT"].inspect}"
    # puts "X-Real-IP: #{request.env["HTTP_X_REAL_IP"].inspect}"
    # puts "Server Hostname: #{Socket.gethostname}"
    # puts "Request Host: #{request.host}"

    query_params = request.query_string
    formatted_params = query_params.empty? ? "" : "?" + query_params
    client_ip = request.ip
    request_host = request.host
    server_hostname = Socket.gethostname
    puts "#{Time.now} - #{client_ip} - #{request_host} - #{server_hostname} -GET /#{formatted_params}"
    # puts "some message with a newline\nand more text"

    erb :index
  end
end
