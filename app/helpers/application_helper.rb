module ApplicationHelper
  def get_tasks_done(id)
    uri = URI('http://localhost:3400/api/v1/groups/'+id.to_s+'/tasks/tasks_done')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Get.new(uri.path, {'Content-Type' =>'application/json', "Authorization" => "Bearer "+current_token})
    res = http.request(req)
    done_status = JSON.parse(res.body, object_class: OpenStruct)
  end
end
