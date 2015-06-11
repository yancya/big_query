module Yancya
  class BigQuery::Table
    def initialize(resource:, tables:)
      @resource = resource
      @tables = tables
    end

    def project_id
      table_reference["projectId"]
    end

    def dataset_id
      table_reference["datasetId"]
    end

    def table_id
      table_reference["tableId"]
    end

    def reload
      @tables.get(
        project_id: project_id,
        dataset_id: dataset_id,
        table_id: table_id
      )
    end

    def delete
      @tables.delete(
        project_id: project_id,
        dataset_id: dataset_id,
        table_id: table_id
      )
    end

    def patch(table_reference:)
      @tables.patch(
        project_id: project_id,
        dataset_id: dataset_id,
        table_id: table_id,
        table: table_reference
      )
    end

    def update(table_reference:)
      @tables.update(
        project_id: project_id,
        dataset_id: dataset_id,
        table_id: table_id,
        table: table_reference
      )
    end

    private
    def table_reference
      @resource["tableReference"]
    end
  end
end

