require_relative 'request_executor'
require_relative 'initializer'

require_relative 'project'

module Yancya
  class BigQuery::Projects
    include Initializer
    include RequestExecutor

    def list
      resources = execute(
        api_method: @bq.api.projects.list
      )

      resources["projects"].map{|resource|
        BigQuery::Project.new(resource: resource, client: @client)
      }
    end
  end
end