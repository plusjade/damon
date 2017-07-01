require 'aws-sdk'
require 'tempfile'

class Store
  OUTPUT_BUCKET = "twenty-output".freeze

  attr_reader :token, :file_object, :file_extension

  def initialize(token:, file_object:, file_extension:)
    @token = token
    @file_object = file_object
    @file_extension = file_extension
  end

  # upload file from disk in a single request, may not exceed 5GB
  def export
    transcode

    File.open(output_file, 'rb') do |file|
      s3.put_object(
        bucket: OUTPUT_BUCKET,
        key: output_filename,
        body: file
      )
      file.close
    end

    object
  ensure
    source_file.unlink
    output_file.unlink
  end

  def object
    @object ||= Aws::S3::Object.new(OUTPUT_BUCKET, output_filename)
  end

  private def s3
    @s3 ||= Aws::S3::Client.new
  end

  private def transcode
    File.open(source_file, "w+b") do |file|
      file_object.rewind
      file.write(file_object.read)
      file.close
    end

    `ffmpeg -i #{source_file.path} #{output_file.path} -y`
  end

  private def source_file
    @source_file ||= Tempfile.new(["s3_uploads_#{token}", file_extension])
  end

  private def output_file
    @output_file ||= Tempfile.new(["s3_uploads_#{token}", output_extension])
  end

  private def output_filename
    "#{token}#{output_extension}"
  end

  private def output_extension
    ".mp3"
  end
end
