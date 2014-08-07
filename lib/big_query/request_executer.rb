module RequestExecuter
  private

  def response_to_json(obj)
    JSON.parse(obj.response.body)
  end

  def execute(api_method:, body_object: nil, parameters: nil)
    response_to_json @client.execute(api_method: api_method,
                                     body_object: body_object,
                                     parameters: parameters)
  end
end