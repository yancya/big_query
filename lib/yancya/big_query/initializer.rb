module Yancya
  module Initializer
    def self.included(_)
      define_method(:initialize) do |bq:|
        @bq = bq
      end
    end
  end
end
