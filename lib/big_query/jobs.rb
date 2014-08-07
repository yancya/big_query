require 'json'

require_relative 'initializer'
require_relative 'request_executer'
require_relative 'job'

class BigQuery::Jobs
  include Initializer
  include RequestExecuter

  def get(project_id:, job_id:)
    resource = execute(
      api_method: @bq.jobs.get,
      parameters: {projectId: project_id, jobId: job_id}
    )

    BigQuery::Job.new(resource: resource, client: @client)
  end

  def get_query_results(project_id:, job_id:)
    execute(
      api_method: @bq.jobs.get_query_results,
      parameters: {projectId: project_id, jobId: job_id}
    )
  end

  def insert(project_id:)
    # TODO: https://developers.google.com/bigquery/docs/reference/v2/jobs/insert
    raise "This method is not yet working"
  end

  def list(project_id:)
    resources = execute(
      api_method: @bq.jobs.list,
      parameters: {projectId: project_id, projection: "full"}
    )

    resources["jobs"].map{|job|
      BigQuery::Job.new(resource: job, client: @client)
    }
  end

  def query(project_id:, sql:)
    resource = execute(
      api_method: @bq.jobs.query,
      body_object: {query: sql},
      parameters: {projectId: project_id}
    )

    BigQuery::Job.new(resource: resource, client: @client)
  end
end

