class VideoListSerializer < ActiveModel::Serializer
  attributes :name, :token

  attribute :url do
    Rails.application.routes.url_helpers.video_url(object.token)
  end

  attribute :created_at do
    object.created_at.in_time_zone(PT).strftime("%m/%d/%Y %I:%M%p %Z")
  end
end
