require_relative 'initializer'
require_relative 'request_executer'

require_relative 'dataset'

class BigQuery::Datasets
  include Initializer
  include RequestExecuter

  def delete(project_id:, dataset_id:)
    execute(
      api_method: @bq.datasets.delete,
      parameters: {projectId: project_id, datasetId: dataset_id}
    )
  end

  def get(project_id:, dataset_id:)
    execute(
      api_method: @bq.datasets.get,
      parameters: {projectId: project_id, datasetId: dataset_id}
    )
  end

  def insert(project_id:, dataset:)
    execute(
      api_method: @bq.datasets.insert,
      parameters: {projectId: project_id},
      body_object: dataset
    )
  end

  def list(project_id:)
    resources = execute(
      api_method: @bq.datasets.list,
      parameters: {projectId: project_id}
    )

    resources["datasets"].map{|resource|
      BigQuery::Dataset.new(
        resource: resource,
        client: @client
      )
    }
  end

  def patch(project_id:, dataset:)
    execute(
      api_method: @bq.datasets.patch,
      parameters: {projectId: project_id},
      body_object: dataset
    )
  end

  def update(project_id:, datasaet_id:, dataset:)
    execute(
      api_method: @bq.datasets.update,
      parameters: {projectId: project_id, datasetId: datasaet_id},
      body_object: dataset
    )
  end
end
