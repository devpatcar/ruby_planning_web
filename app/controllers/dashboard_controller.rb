class DashboardController < ApplicationController
  before_action :authorize

  def index
    uri = URI('http://localhost:3400/api/v1/groups')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    res = http.request(req)

    @groups = JSON.parse(res.body, object_class: OpenStruct)
  end

  def edit
    uri = URI('http://localhost:3400/api/v1/groups/'+params['id'])
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    res = http.request(req)

    @group = JSON.parse(res.body, object_class: OpenStruct)
    @tasks = []
  end

  def update
    uri = URI('http://localhost:3400/api/v1/groups/'+params[:group][:id])
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Put.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    req.body = {"name" => params[:group][:name], "description" => params[:group][:description]}.to_json
    res = http.request(req)

    json = JSON.parse(res.body)
    redirect_to '/dashboard'
  end

  def new
  end

  def create
    uri = URI('http://localhost:3400/api/v1/groups')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    req.body = {"name" => params[:name], "description" => params[:description]}.to_json
    res = http.request(req)

    json = JSON.parse(res.body)

    redirect_to '/dashboard'
  end

  def destroy
    uri = URI('http://localhost:3400/api/v1/groups/'+params['id'])
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Delete.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    res = http.request(req)

    redirect_to '/dashboard'
  end
end
