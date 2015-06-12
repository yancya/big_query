require_relative 'request_executor'

module Yancya
  class BigQuery
    class Resource
      include RequestExecutor

      def initialize(bq:)
        @bq = bq
      end
    end
  end
end