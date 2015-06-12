require_relative 'resource'
require_relative 'table'

module Yancya
  class BigQuery
    class Tables < Resource
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

        (resources["tables"]||[]).map do |resource|
          BigQuery::Table.new(resource: resource, tables: self)
        end
      end

      def patch(project_id:, dataset_id:, table_id:, table:)
        resource = execute(
          api_method: @bq.api.tables.patch,
          parameters: {
            datasetId: dataset_id,
            projectId: project_id,
            tableId: table_id,
          },
          body_object: table
        )

        BigQuery::Table.new(resource: resource, tables: self)
      end

      def update(project_id:, dataset_id:, table_id:, table:)
        resource = execute(
          api_method: @bq.api.tables.update,
          parameters: {
            datasetId: dataset_id,
            projectId: project_id,
            tableId: table_id,
          },
          body_object: table
        )

        BigQuery::Table.new(resource: resource, tables: self)
      end
    end
  end
end