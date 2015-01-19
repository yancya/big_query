require 'test-unit'
require 'big_query'

class TestBigQuery < Test::Unit::TestCase
  setup do
    @bq = BigQuery.new(
      key_path: ENV["GCP_KEY_PATH"],
      issuer: ENV["GCP_ISSUER"]
    )
  end

  test "select without table" do
    job = @bq.jobs.query(project_id: ENV["BQ_PROJECT_ID"], sql: "select 1 as a, 2 as b, 3 as c")
    begin
      result = job.query_results
    end until result["jobComplete"]

    assert do
      "1,2,3" == result["rows"].map{|row| row["f"].map{|col| col["v"]}.join(",")}.first
    end
  end
end