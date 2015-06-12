require 'test-unit'
require 'pp'
require_relative '../lib/yancya/big_query'

class TestBigQuery < Test::Unit::TestCase
  TEST_DATASET_ID = "test_dataset_for_yancya_big_query_gem"
  TEST_DATASET_ID_MODIFIED = "test_dataset_for_yancya_big_query_gem_"
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
    @bq = Yancya::BigQuery.new(
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

  test "get dataset" do
    dataset = @bq.
      datasets.
      get(
        project_id: @project_id,
        dataset_id: TEST_DATASET_ID
      )["datasetReference"]

    assert { TEST_DATASET_ID == dataset["datasetId"] }
  end

  test "jobs list" do
    job_list = @bq.jobs.list(project_id: @project_id)
    assert { job_list.is_a? Array }
  end

  test "get job" do
    job_id = @bq.jobs.list(project_id: @project_id).last.job_id
    assert do
      job_id == @bq.jobs.get(project_id: @project_id, job_id: job_id).job_id
    end
  end

  test "project list" do
    assert do
      @bq.projects.list.map{ |project| project.project_id }.include? @project_id
    end
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
    assert { table_data.list["totalRows"] }
  end

  test "table list" do
    create_table

    assert { 1 == @bq.tables.list(project_id: @project_id, dataset_id: TEST_DATASET_ID).size }
  end

  test "get table"do
    create_table

    table = @bq.tables.get(project_id: @project_id, dataset_id: TEST_DATASET_ID, table_id: TEST_TABLE_ID)

    assert { TEST_TABLE_ID == table.table_id }
  end

  test "delete table" do
    table = create_table
    @bq.tables.delete(project_id: @project_id, dataset_id: TEST_DATASET_ID, table_id: table.table_id)

    assert { @bq.tables.list(project_id: @project_id, dataset_id: TEST_DATASET_ID).empty? }
  end

  test "patch table" do
    create_table

    table = @bq.tables.patch(
      project_id: @project_id,
      dataset_id: TEST_DATASET_ID,
      table_id: TEST_TABLE_ID,
      table: {
        description: "hello world"
      }
    )

    assert { "hello world" == table.description }
  end

  test "update table" do
    schema = create_table.schema

    table = @bq.tables.update(
      project_id: @project_id,
      dataset_id: TEST_DATASET_ID,
      table_id: TEST_TABLE_ID,
      table: {
        schema: schema.tap { |hash| hash["fields"] << { name: "hoge", type: "STRING" }; break hash }
      }
    )

    assert { table.schema["fields"].map { |field| field["name"] }.include? "hoge" }
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

    loop.each_with_index do |_, index|
      raise 'Job timeout' if index > 60

      result = job.query_results

      break result if result["jobComplete"]

      sleep(1)
    end
  end
end