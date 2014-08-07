class BigQuery::Dataset
  def initialize(resource:, client:)
    @resource = resource
    @tables = Tables.new(client: client)
  end

  def tables
    @tables.list(
      project_id: project_id,
      dataset_id: dataset_id
    )
  end

  def project_id
    dataset_reference[:projectId]
  end

  def dataset_id
    dataset_reference[:datasetId]
  end

  private

  def dataset_reference
    @resource[:datasetReference]
  end
end