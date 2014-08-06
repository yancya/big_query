require_relative "big_query/version"
require_relative "big_query/dataset"
require_relative "big_query/job"
require_relative "big_query/project"
require_relative "big_query/tabledata"
require_relative "big_query/table"

require 'google/api_client'

class BigQuery
  def initialize(key_path:, service_mail_address:, project_id:)
    @key_path = key_path
    @service_mail_address = service_mail_address
    @project_id = project_id
 
    app_info = {
      application_name: "something",
      application_version: "0",
    }
 
    @client = Google::APIClient.new(app_info)
 
    asserter = Google::APIClient::JWTAsserter.new(
      @service_mail_address,
      "https://www.googleapis.com/auth/bigquery",
      Google::APIClient::PKCS12.load_key(File.open(@key_path), "notasecret")
    )
 
    @client.authorization = asserter.authorize
  end
 
  def datasets
    Dataset.new(@project_id, @client)
  end
 
  def jobs
    Job.new(@project_id, @client)
  end
 
  def projects
    Project.new(@project_id, @client)
  end
 
  def tabledata
    Tabledata.new(@project_id, @client)
  end
 
  def tables
    Table.new(@project_id, @client)
  end
end
