require_relative 'initializer'
require_relative 'request_executor'

require_relative 'table'

module Yancya
  class BigQuery::Tables
    include Initializer
    include RequestExecutor

    def delete(project_id:, dataset_id:, table_id:)
      execute(
        api_method: @bq.api.tables.delete,
        parameters: {
          datasetId: dataset_id,
          projectId: project_id,
          tableId: table_id,
        }
      )
    end

    def get(project_id:, dataset_id:, table_id:)
      resource = execute(
        api_method: @bq.api.tables.get,
        parameters: {
          datasetId: dataset_id,
          projectId: project_id,
          tableId: table_id,
        }
      )

      BigQuery::Table.new(resource: resource, tables: self)
    end

    def insert(project_id:, dataset_id:, table:)
      resource = execute(
        api_method: @bq.api.tables.insert,
        parameters: {
          datasetId: dataset_id,
          projectId: project_id,
        },
        body_object: table
      )

      BigQuery::Table.new(resource: resource, tables: self)
    end

    def list(project_id:, dataset_id:)
      resources = execute(
        api_method: @bq.api.tables.list,
        parameters: {
          datasetId: dataset_id,
          projectId: project_id,
        }
      )

      resources["tables"].map{|resource|
        BigQuery::Table.new(resource: resource, tables: self)
      }
    end

    def patch(project_id:, dataset_id:, table_id:, table_reference:)
      resource = execute(
        api_method: @bq.api.tables.get,
        parameters: {
          datasetId: dataset_id,
          projectId: project_id,
          tableId: table_id,
        },
        body_object: table_reference
      )

      BigQuery::Table.new(resource: resource, tables: self)
    end

    def update(project_id:, dataset_id:, table_id:, table_reference:)
      resource = execute(
        api_method: @bq.api.tables.get,
        parameters: {
          datasetId: dataset_id,
          projectId: project_id,
          tableId: table_id,
        },
        body_object: table_reference
      )

      BigQuery::Table.new(resource: resource, tables: self)
    end
  end
end