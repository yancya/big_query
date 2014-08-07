require_relative 'jobs'
require_relative 'datasets'

class BigQuery::Project
  def initialize(resource:, client:)
    @resource = resource
    @jobs = BigQuery::Jobs.new(client: client)
    @datasets = BigQuery::Datasets.new(client: client)
  end

  def jobs
    @jobs.list(project_id: project_id)
  end

  def datasets
    @datasets.list(project_id: project_id)
  end

  def project_id
    @resource["projectReference"]["projectId"]
  end
end