# BigQuery

Google BigQuery API client library

## Installation

Add this line to your application's Gemfile:

    gem 'big_query', github: "yancya/big_query"

And then execute:

    $ bundle

Or build and install it yourself as:

    $ git clone git@github.com:yancya/big_query.git
    $ cd big_query
    $ rake install

## Usage

```
bq = BigQuery.new(
  key_path: #path_to_secret_key
  service_mail_address: #mail_address
  project_id: #project_id
)

job = bq.jobs.query "select 1 as a, 2 as b, 3 as c"
result = bq.jobs.get_query_results job["jobReference"]["jobId"]

result["schema"]["fields"].map{|f| f["name"]}.join(",") #=> "a,b,c"
result["rows"].map{|row| row["f"].map{|col| col["v"]}.join(",")} #=> ["1,2,3"]
```

## Google BigQuery API Reference

https://developers.google.com/bigquery/docs/reference/v2/

## Contributing

1. Fork it ( https://github.com/[my-github-username]/big_query/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
