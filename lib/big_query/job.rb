class BigQuery::Job
  def initialize(resource, client)
    @resource = resource
    @jobs = Jobs.new(client: client)
  end

  def query_results
    @jobs.get_query_results(
      project_id: @resource[:jobReference][:projectId],
      job_id: @resource[:jobReference][:jobId]
    )
  end

  def query
    @resource[:configuration][:query][:query]
  end

  def state
    status[:state]
  end

  def errors
    status[:errors]
  end

  private
  def status
    @resource[:status][:errors]
  end
end