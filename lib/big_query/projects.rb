require_relative 'initializer'
require_relative 'request_executer'

class BigQuery::Projects
  include Initializer
  include RequestExecuter

  def list
    resources = execute(api_method: @bq.projects.list)

    resources[:projects].map{|resource|
      Project.new(resource: resource, client: @client)
    }
  end
end
