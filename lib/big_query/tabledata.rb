require_relative 'request_executer'

class BigQuery::Tabledata
  include RequestExecuter

  def initialize(project_id:, dataset_id:, table_id:, client:)
    @project_id = project_id
    @dataset_id = dataset_id
    @table_id = table_id
    @client = client
  end

  def insert_all(rows)
    execute(
      api_method: @bq.tabledata.insert_all,
      body_object: {kind: "bigquery#tableDataInsertAllRequest", rows: rows},
      parameters: {
        datasetId: @dataset_id,
        projectId: @project_id,
        tableId: @table_id
      }
    )
  end

  def list
    execute(
      api_method: @bq.tabledata.insert_all,
      parameters: {
        datasetId: @dataset_id,
        projectId: @project_id,
        tableId: @table_id
      }
    )
  end
end
