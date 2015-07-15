require_relative 'resource'
require_relative 'job'

module Yancya
  class BigQuery
    class Jobs < Resource
     def cancel(project_id:, job_id:)
       execute(
         api_method: @bq.api.jobs.cancel,
         parameters: { projectId: project_id, jobId: job_id }
       )
     end

     def get(project_id:, job_id:)
       resource = execute(
         api_method: @bq.api.jobs.get,
         parameters: { projectId: project_id, jobId: job_id }
       )

       BigQuery::Job.new(resource: resource, bq: @bq)
     end

     def get_query_results(project_id:, job_id:, page_token: nil)
       execute(
         api_method: @bq.api.jobs.get_query_results,
         parameters: {
           projectId: project_id,
           jobId: job_id,
           pageToken: page_token
         }
       )
     end

     def insert(project_id:)
       # TODO: https://developers.google.com/bigquery/docs/reference/v2/jobs/insert
       raise "This method is not yet working"
     end

     def list(project_id:)
       resources = execute(
         api_method: @bq.api.jobs.list,
         parameters: { projectId: project_id, projection: "full" }
       )

       resources["jobs"].map{|job|
         BigQuery::Job.new(resource: job, bq: @bq)
       }
     end

     def query(project_id:, sql:)
       resource = execute(
         api_method: @bq.api.jobs.query,
         body_object: { query: sql },
         parameters: { projectId: project_id }
       )

       BigQuery::Job.new(resource: resource, bq: @bq)
     end
    end
  end
end