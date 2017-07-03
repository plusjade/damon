class VideosController < ActionController::Base
  def index
    videos = Video.all.order("created_at desc")

    data = ActiveModelSerializers::SerializableResource.new(
      videos,
      each_serializer: VideoListSerializer
    )

    render json: {data: data}
  end

  def show
    video = Video.find_by_token!(params[:token])

    render json: {data: VideoSerializer.new(video)}
  end

  def destroy

  end

  def update
    puts params.inspect
    video = Video.find_by_token(params[:token])
    unless video
      video = Video.create!(token: params[:token])
    end

    if (payload = params[:payload].presence)
      video.payload = payload
    end

    if (blob = params[:blob].presence)
      file_extension = blob.content_type.split("/").last
      store = Store.new(token: video.token, file_object: blob.tempfile, file_extension: file_extension)
      store.export
      video.audio_url = store.object.public_url
    end

    video.save!

    render json: {video: video}
  end
end
