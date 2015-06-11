require_relative "big_query/version"
require_relative "big_query/datasets"
require_relative "big_query/jobs"
require_relative "big_query/projects"
require_relative "big_query/tabledata"
require_relative "big_query/tables"

require 'google/api_client'

module Yancya
  class BigQuery
    attr_reader :client

    BQ = Struct.new(:client) do
      def api
        client.discovered_api("bigquery", "v2")
      end
    end

    def initialize(key_path:,
                   issuer:,
                   application_name: "github.com/yancya/big_query",
                   application_version: BigQuery::VERSION)

      app_info = {
        application_name: application_name,
        application_version: application_version
      }

      client = Google::APIClient.new(app_info)

      asserter = Google::APIClient::JWTAsserter.new(
        issuer,
        "https://www.googleapis.com/auth/bigquery",
        Google::APIClient::PKCS12.load_key(File.open(key_path), "notasecret")
      )

      client.authorization = asserter.authorize

      @bq = BQ.new(client)
    end

    def datasets
      Datasets.new(bq: @bq)
    end

    def jobs
      Jobs.new(bq: @bq)
    end

    def projects
      Projects.new(bq: @bq)
    end

    def tabledata(project_id:, dataset_id:, table_id:)
      Tabledata.new(
        project_id: project_id,
        dataset_id: dataset_id,
        table_id: table_id,
        bq: @bq
      )
    end

    def tables
      Tables.new(bq: @bq)
    end
  end
end