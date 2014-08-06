module Initializer
  def self.included(_)
    define_method(:initialize) do |project_id, client|
      @project_id = project_id
      @client = client
      @bq = client.discovered_api("bigquery", "v2")
    end
  end
end
