require_relative 'resource'
require_relative 'project'

module Yancya
  class BigQuery
    class Projects < Resource
      def list
        resources = execute(
          api_method: @bq.api.projects.list
        )

        resources["projects"].map do |resource|
          BigQuery::Project.new(resource: resource, bq: @bq)
        end
      end
    end
  end
end