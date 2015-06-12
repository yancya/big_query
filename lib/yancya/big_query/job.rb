module Yancya
  class BigQuery
    class Job
      def initialize(resource:, bq:)
        @resource = resource
        @jobs = BigQuery::Jobs.new(bq: bq)
      end

      def query_results
        @jobs.get_query_results(
          project_id: project_id,
          job_id: job_id
        )
      end

      def reload
        @jobs.get(project_id: project_id, job_id: job_id)
      end

      def project_id
        job_reference["projectId"]
      end

      def job_id
        job_reference["jobId"]
      end

      def query
        (configuration["query"]||{})["query"]
      end

      def state
        status["state"]
      end

      def errors
        status["errors"]
      end

      private

      def configuration
        @resource["configuration"]
      end

      def status
        @resource["status"]
      end

      def job_reference
        @resource["jobReference"]
      end
    end
  end
end