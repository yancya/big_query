require_relative 'jobs'
require_relative 'datasets'
require_relative 'request_executor'

module Yancya
  class BigQuery
    class Project
      include RequestExecutor

      def initialize(resource:, bq:)
        @resource = resource
        @jobs = BigQuery::Jobs.new(bq: bq)
        @datasets = BigQuery::Datasets.new(bq: bq)
        @bq = bq
      end

      def query(sql)
        @jobs.query(project_id: project_id, sql: sql)
      end

      def jobs
        @jobs.list(project_id: project_id)
      end

      def datasets
        @datasets.list(project_id: project_id)
      end

      def project_id
        @resource["projectReference"]["projectId"]
      end
    end
  end
end

