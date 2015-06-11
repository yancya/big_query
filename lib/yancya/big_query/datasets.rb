require_relative 'initializer'
require_relative 'request_executor'

require_relative 'dataset'

module Yancya
  class BigQuery::Datasets
    include Initializer
    include RequestExecutor

    def delete(project_id:, dataset_id:)
      execute(
        api_method: @bq.api.datasets.delete,
        parameters: {projectId: project_id, datasetId: dataset_id, deleteContents: true}
      )
    end

    def get(project_id:, dataset_id:)
      execute(
        api_method: @bq.api.datasets.get,
        parameters: {projectId: project_id, datasetId: dataset_id}
      )
    end

    def insert(project_id:, dataset:)
      execute(
        api_method: @bq.api.datasets.insert,
        parameters: {projectId: project_id},
        body_object: dataset
      )
    end

    def list(project_id:)
      resources = execute(
        api_method: @bq.api.datasets.list,
        parameters: {projectId: project_id}
      )

      resources["datasets"].map{ |resource|
        Yancya::BigQuery::Dataset.new(
          resource: resource,
          bq: @bq
        )
      }
    end

    def patch(project_id:, dataset_id:, dataset:)
      execute(
        api_method: @bq.api.datasets.patch,
        parameters: {projectId: project_id, datasetId: dataset_id},
        body_object: dataset
      )
    end

    def update(project_id:, dataset_id:, dataset:)
      execute(
        api_method: @bq.api.datasets.update,
        parameters: {projectId: project_id, datasetId: dataset_id},
        body_object: dataset
      )
    end
  end
end