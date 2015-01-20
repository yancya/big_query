module RequestExecuter
  private

  def response_to_json(obj)
    return {} if obj.response.body.empty?
    JSON.parse(obj.response.body).tap do |resource|
      raise resource["error"].to_s if resource["error"]
      break resource
    end
  end

  def execute(api_method:, body_object: nil, parameters: nil)
    response_to_json @client.execute(api_method: api_method,
                                     body_object: body_object,
                                     parameters: parameters)
  end
end