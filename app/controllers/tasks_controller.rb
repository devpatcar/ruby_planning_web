class TasksController < ApplicationController
  before_action :authorize
  before_action :set_group_id

  def index
    uri = URI('http://localhost:3400/api/v1/groups/'+@group_id+'/tasks')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    res = http.request(req)
    @tasks = JSON.parse(res.body, object_class: OpenStruct)
  end

  def edit
    uri = URI('http://localhost:3400/api/v1/groups/'+@group_id+'/tasks/'+params[:id])
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    res = http.request(req)

    @task = JSON.parse(res.body, object_class: OpenStruct)

  end

  def update
    uri = URI('http://localhost:3400/api/v1/groups/'+@group_id+'/tasks/'+params[:id])
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Put.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    req.body = {"name" => params[:task][:name], "description" => params[:task][:description], "input_type" => params[:task][:input_type], "done" => params[:task][:done], "result" => params[:task][:result]}.to_json
    res = http.request(req)

    json = JSON.parse(res.body)
    redirect_to '/dashboard/'+@group_id+'/tasks/'
  end

  def new
  end

  def create
    uri = URI('http://localhost:3400/api/v1/groups/'+@group_id+'/tasks')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    req.body = {"name" => params[:name], "description" => params[:description], "input_type" => params[:input_type], "group_id" => @group_id }.to_json
    res = http.request(req)

    json = JSON.parse(res.body)

    redirect_to '/dashboard/'+@group_id+'/tasks'
  end

  def destroy
    uri = URI('http://localhost:3400/api/v1/groups/'+@group_id+'/tasks/'+params[:id])
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Delete.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    res = http.request(req)

    redirect_to '/dashboard/'+@group_id+'/tasks'
  end

  private

  def set_group_id
    @group_id = params['group_id']
  end
end
