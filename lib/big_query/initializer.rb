module Initializer
  def self.included(_)
    define_method(:initialize) do |client|
      @client = client
      @bq = client.discovered_api("bigquery", "v2")
    end
  end
end
