require 'json'
require_relative 'initializer'

class Job
  include Initializer

  def get(job_id)
    execute(
      api_method: @bq.jobs.get,
      body_object: nil,
      parameters: {projectId: @project_id, jobId: job_id}
    )
  end

  def get_query_results(job_id)
    execute(
      api_method: @bq.jobs.get_query_results,
      body_object: nil,
      parameters: {projectId: @project_id, jobId: job_id}
    )
  end

  def insert
     execute(
      api_method: @bq.jobs.insert,
      body_object: nil,
      parameters: {projectId: @project_id}
    )
  end    

  def list
    execute(
      api_method: @bq.jobs.list,
      body_object: nil,
      parameters: {projectId: @project_id}
    )
  end

  def query(sql)
    execute(
      api_method: @bq.jobs.query,
      body_object: {query: sql},
      parameters: {projectId: @project_id}
    )
  end

  private
  def response_to_json(obj)
    JSON.parse(obj.response.body)
  end

  def execute(api_method:, body_object:, parameters:)
    response_to_json @client.execute(
      api_method: api_method,
      body_object: body_object,
      parameters: parameters
    )
  end
end

