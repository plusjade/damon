class DaysSerializer < ActiveModel::Serializer
  def entries
    ActiveModelSerializers::SerializableResource.new(
      object[:entries],
      each_serializer: EntrySerializer
    )
  end

  def as_json
    puts ""
    {
      occured_at: object[:occured_at],
      entries: entries
    }
  end
end
