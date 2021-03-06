# BigQuery

[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/yancya/big_query?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Google BigQuery API client library

## Installation

Add this line to your application's Gemfile:

    gem 'yancya-big_query'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yancya-big_query

## Usage

```rb
bq = Yancya::BigQuery.new(
  key_path: "path_to_secret_key"
  issuer: "mail@address"
)

job = bq.jobs.query(
  project_id: "name_of_project",
  sql: "select 1 as a, 2 as b, 3 as c"
)

begin
  result = job.query_results
end until result["jobComplete"]

result["schema"]["fields"].map{|f| f["name"]}.join(",") #=> "a,b,c"
result["rows"].map{|row| row["f"].map{|col| col["v"]}.join(",")} #=> ["1,2,3"]
```

## Google BigQuery API Reference

https://developers.google.com/bigquery/docs/reference/v2/

## Contributing

1. Fork it ( https://github.com/yancya/big_query/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
