class WorkController < ApplicationController
  before_action :authorize
  before_action :set_group_id

  def index
    uri = URI('http://localhost:3400/api/v1/groups/work/false')
    if params[:filter_done] == "true"
      uri = URI('http://localhost:3400/api/v1/groups/work/true')
      @filter_done = "false"
    else
      @filter_done = "true"
    end
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    res = http.request(req)

    @groups = JSON.parse(res.body, object_class: OpenStruct)
  end

  def tasks
    uri = URI('http://localhost:3400/api/v1/groups/'+@group_id+'/tasks')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    res = http.request(req)
    @tasks = JSON.parse(res.body, object_class: OpenStruct)
  end

  def task
    uri = URI('http://localhost:3400/api/v1/groups/'+@group_id+'/tasks/'+params[:id])
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    res = http.request(req)

    @task = JSON.parse(res.body, object_class: OpenStruct)
  end

  def submit_task
    uri = URI('http://localhost:3400/api/v1/groups/'+@group_id+'/tasks/'+params[:id])
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    res = http.request(req)

    @task = JSON.parse(res.body, object_class: OpenStruct)

    if @task.present?
      uri = URI('http://localhost:3400/api/v1/groups/'+@group_id+'/tasks/'+params[:id])
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Put.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
      req.body = {"name" => @task.name, "description" => @task.description, "input_type" => @task.input_type,"done" => true, "result" => params[:task][:result]}.to_json
      res = http.request(req)

      json = JSON.parse(res.body)
    end
    redirect_to '/dashboard/'+@group_id+'/work/'
  end

  private

  def set_group_id
    @group_id = params['group_id']
  end
end