class SchedulingsController < ApplicationController
  before_action :authorize
  before_action :set_group_id

  def index
    uri = URI('http://localhost:3400/api/v1/groups/'+@group_id+'/schedulings')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    res = http.request(req)
    @schedulings = JSON.parse(res.body, object_class: OpenStruct)
  end

  def edit
    uri = URI('http://localhost:3400/api/v1/groups/'+@group_id+'/schedulings/'+params[:id])
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    res = http.request(req)

    @scheduling = JSON.parse(res.body, object_class: OpenStruct)
    @scheduling.start_date = @scheduling.start_date.to_date
    @scheduling.end_date = @scheduling.end_date.to_date


  end

  def update
    uri = URI('http://localhost:3400/api/v1/groups/'+@group_id+'/schedulings/'+params[:id])
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Put.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    req.body = {"name" => params[:scheduling][:name], "description" => params[:scheduling][:description], "start_date" => params[:scheduling][:start_date], "end_date" => params[:scheduling][:end_date], "monday" => params[:scheduling][:monday], "tuesday" => params[:scheduling][:tuesday], "wednesday" => params[:scheduling][:wednesday], "thursday" => params[:scheduling][:thursday], "friday" => params[:scheduling][:friday], "saturday" => params[:scheduling][:saturday], "sunday" => params[:scheduling][:sunday]}.to_json
    res = http.request(req)

    json = JSON.parse(res.body)
    redirect_to '/dashboard/'+@group_id+'/schedulings/'
  end

  def new
  end

  def create
    uri = URI('http://localhost:3400/api/v1/groups/'+@group_id+'/schedulings')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    req.body = {"group_id" => @group_id, "name" => params[:name], "description" => params[:description], "start_date" => params[:start_date], "end_date" => params[:end_date], "monday" => params[:monday], "tuesday" => params[:tuesday], "wednesday" => params[:wednesday], "thursday" => params[:thursday], "friday" => params[:friday], "saturday" => params[:saturday], "sunday" => params[:sunday]}.to_json
    res = http.request(req)

    json = JSON.parse(res.body)

    redirect_to '/dashboard/'+@group_id+'/schedulings'
  end

  def destroy
    uri = URI('http://localhost:3400/api/v1/groups/'+@group_id+'/schedulings/'+params[:id])
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Delete.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    res = http.request(req)

    redirect_to '/dashboard/'+@group_id+'/schedulings'
  end

  private

  def set_group_id
    @group_id = params['group_id']
  end

  def scheduling_params
    params.permit(:group_id, :name, :description, :start_date, :end_date, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday)
  end
end
