class SessionsController < ApplicationController
  require 'net/http'
  require 'json'

  def new
  end

  def signup
  end

  def register
    email = params[:session][:email]
    password = params[:session][:password]
    uri = URI('http://localhost:3400/api/v1/auth/register')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
    req.body = {"user" => email, "password" => password}.to_json
    res = http.request(req)

    json = JSON.parse(res.body, object_class: OpenStruct)

    if json.email.present?
      redirect_to '/login'
    else
      flash.now[:danger] = 'Invalid email/password combination'
      redirect_to '/signup'
    end
  end

  def create
    user_token = nil
    begin
      email = params[:session][:email]
      password = params[:session][:password]
      uri = URI('http://localhost:3400/api/v1/auth')
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
      req.body = {"user" => email, "password" => password}.to_json
      res = http.request(req)

      json = JSON.parse(res.body)
      user_token = json['token']

      if user_token.present?
        log_in(user_token, email)
        redirect_to '/'
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    rescue => e
      flash.now[:danger] = 'Error, please try again.'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
