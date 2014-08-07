require_relative 'initializer'
require_relative 'request_executer'

class BigQuery::Tables
  include Initializer
  include RequestExecuter

  def delete(project_id:, dataset_id:, table_id:)
    execute(
      api_method: @bq.tables.delete,
      parameters: {
        datasaetId: dataset_id,
        projectId: project_id,
        tableId: table_id,
      }
    )
  end

  def get(project_id:, dataset_id:, table_id:)
    resource = execute(
      api_method: @bq.tables.get,
      parameters: {
        datasaetId: dataset_id,
        projectId: project_id,
        tableId: table_id,
      }
    )

    Table.new(resource: resource, client: @client)
  end

  def insert(project_id:, dataset_id:, table:)
    resource = execute(
      api_method: @bq.tables.insert,
      parameters: {
        datasaetId: dataset_id,
        projectId: project_id,
      },
      body_object: table
    )

    Table.new(resource: resource, client: @client)
  end

  def list(project_id:, dataset_id:)
    resources = execute(
      api_method: @bq.tables.list,
      parameters: {
        datasaetId: dataset_id,
        projectId: project_id,
      }
    )

    resources[:tables].map{|resource|
      Table.new(resource: resource, client: client)
    }
  end

  def patch(project_id:, dataset_id:, table_id:, table:)
    resource = execute(
      api_method: @bq.tables.get,
      parameters: {
        datasaetId: dataset_id,
        projectId: project_id,
        tableId: table_id,
      },
      body_object: table
    )

    Table.new(resource: resource, client: @client)
  end

  def update(project_id:, dataset_id:, table_id:, table:)
    resource = execute(
      api_method: @bq.tables.get,
      parameters: {
        datasaetId: dataset_id,
        projectId: project_id,
        tableId: table_id,
      },
      body_object: table
    )

    Table.new(resource: resource, client: @client)
  end
end