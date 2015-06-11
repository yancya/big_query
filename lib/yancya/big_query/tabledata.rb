require_relative 'request_executor'

module Yancya
  class BigQuery::Tabledata
    include RequestExecutor

    def initialize(project_id:, dataset_id:, table_id:, bq:)
      @project_id = project_id
      @dataset_id = dataset_id
      @table_id = table_id
      @bq = bq
    end

    def insert_all(rows)
      execute(
        api_method: @bq.api.tabledata.insert_all,
        body_object: {rows: rows},
        parameters: {
          datasetId: @dataset_id,
          projectId: @project_id,
          tableId: @table_id
        }
      )
    end

    def list
      execute(
        api_method: @bq.api.tabledata.list,
        parameters: {
          datasetId: @dataset_id,
          projectId: @project_id,
          tableId: @table_id
        }
      )
    end
  end
end