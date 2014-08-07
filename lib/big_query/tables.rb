require_relative 'initializer'
require_relative 'request_executer'

require_relative 'table'

class BigQuery::Tables
  include Initializer
  include RequestExecuter

  def delete(project_id:, dataset_id:, table_id:)
    execute(
      api_method: @bq.tables.delete,
      parameters: {
        datasetId: dataset_id,
        projectId: project_id,
        tableId: table_id,
      }
    )
  end

  def get(project_id:, dataset_id:, table_id:)
    resource = execute(
      api_method: @bq.tables.get,
      parameters: {
        datasetId: dataset_id,
        projectId: project_id,
        tableId: table_id,
      }
    )

    BigQuery::Table.new(resource: resource, client: @client)
  end

  def insert(project_id:, dataset_id:, table:)
    resource = execute(
      api_method: @bq.tables.insert,
      parameters: {
        datasetId: dataset_id,
        projectId: project_id,
      },
      body_object: table
    )

    BigQuery::Table.new(resource: resource, client: @client)
  end

  def list(project_id:, dataset_id:)
    resources = execute(
      api_method: @bq.tables.list,
      parameters: {
        datasetId: dataset_id,
        projectId: project_id,
      }
    )

    resources["tables"].map{|resource|
      BigQuery::Table.new(resource: resource, client: @client)
    }
  end

  def patch(project_id:, dataset_id:, table_id:, table:)
    resource = execute(
      api_method: @bq.tables.get,
      parameters: {
        datasetId: dataset_id,
        projectId: project_id,
        tableId: table_id,
      },
      body_object: table
    )

    BigQuery::Table.new(resource: resource, client: @client)
  end

  def update(project_id:, dataset_id:, table_id:, table:)
    resource = execute(
      api_method: @bq.tables.get,
      parameters: {
        datasetId: dataset_id,
        projectId: project_id,
        tableId: table_id,
      },
      body_object: table
    )

    BigQuery::Table.new(resource: resource, client: @client)
  end
end