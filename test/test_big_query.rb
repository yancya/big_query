require 'test-unit'
require_relative '../lib/big_query'

class TestBigQuery < Test::Unit::TestCase
  TEST_DATASET_ID = "test_dataset_for_yancya_big_query_gem"
  TEST_TABLE_ID = "test_table"
  TEST_TABLE_INFO = {
      schema: {
        fields: [
          {name: "column_s", type: "STRING"},
          {name: "column_i", type: "INTEGER"},
          {name: "column_f", type: "FLOAT"},
          {name: "column_b", type: "BOOLEAN"}
        ]
      },
      tableReference: {
        tableId: TEST_TABLE_ID
      }
    }

  setup do
    @bq = BigQuery.new(
      key_path: ENV["GCP_KEY_PATH"],
      issuer: ENV["GCP_ISSUER"]
    )

    @project_id = ENV["BQ_PROJECT_ID"]

    if @bq.datasets.list(project_id: @project_id).map{ |ds| ds.dataset_id }.include? TEST_DATASET_ID
      @bq.datasets.delete(project_id: @project_id, dataset_id: TEST_DATASET_ID)
    end

    dataset = {
      datasetReference: {
        datasetId: TEST_DATASET_ID
      }
    }

    @bq.datasets.insert(project_id: @project_id, dataset: dataset)
  end

  teardown do
    @bq.datasets.delete(project_id: @project_id, dataset_id: TEST_DATASET_ID)
  end

  test "select without table" do
    result = execute_query("select 1 as a, 2 as b, 3 as c")

    assert do
      "1,2,3" == result["rows"].map{|row| row["f"].map{|col| col["v"]}.join(",")}.first
    end
  end

  test "create table" do
    result = create_table
    assert { TEST_TABLE_ID == result.table_id }
  end

  test "insert_all data" do
    create_table
    table_data = @bq.tabledata(
      project_id: @project_id,
      dataset_id: TEST_DATASET_ID,
      table_id: TEST_TABLE_ID
    )
    rows = [{ json: { column_s: "hoge", column_i: 1, column_f: 0.1, column_b: false } }]
    assert { table_data.insert_all(rows)["insertErrors"].nil? }
  end

  private

  def create_table
    @bq.tables.insert(
      project_id: @project_id,
      dataset_id: TEST_DATASET_ID,
      table: TEST_TABLE_INFO
    )
  end

  def execute_query(sql)
    job = @bq.jobs.query(project_id: @project_id, sql: sql)

    begin
      result = job.query_results
    end until result["jobComplete"]

    result
  end
end