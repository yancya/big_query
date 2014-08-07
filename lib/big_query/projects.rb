require_relative 'request_executer'
require_relative 'initializer'

require_relative 'project'

class BigQuery::Projects
  include Initializer
  include RequestExecuter

  def list
    resources = execute(
      api_method: @bq.projects.list
    )

    resources["projects"].map{|resource|
      BigQuery::Project.new(resource: resource, client: @client)
    }
  end
end
