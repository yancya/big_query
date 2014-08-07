class BigQuery::Table
  def initialize(resource:, client:)
    @resource = resource
    @tables = Tables.new(client: client)
  end

  def project_id
    table_reference[:projectId]
  end

  def dataset_id
    table_reference[:datasetId]
  end

  def table_id
    table_reference[:tableId]
  end

  def reload
    @tables.get(
      project_id: project_id,
      dataset_id: dataset_id,
      table_id: table_id
    )
  end

  def delete
    @tables.delete(
      project_id: project_id,
      dataset_id: dataset_id,
      table_id: table_id
    )
  end

  def patch(table:)
    @tables.patch(
      project_id: project_id,
      dataset_id: dataset_id,
      table_id: table_id,
      table: table
    )
  end

  def update(table:)
    @tables.update(
      project_id: project_id,
      dataset_id: dataset_id,
      table_id: table_id,
      table: table
    )
  end

  private
  def table_reference
    @resource[:tableReference]
  end
end