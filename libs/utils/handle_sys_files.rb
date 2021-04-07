# frozen_string_literal: true

class HandleSysFiles
  def initialize(directory:, filename:)
    @directory = directory
    @filepath = directory + filename
  end

  def read_file
    File.exist?(filepath)
    File.readlines(filepath)
  end

  def file_base_name
    File.basename(filepath, File.extname(filepath))
  end

  def filename_extension
    File.extname(filepath)
  end

  def rename_with_timestamp
    new_filename = directory + file_base_name + timestamp + filename_extension
    File.rename(filepath, new_filename)
  end

  private

  def timestamp
    Time.now.utc.to_s.gsub(' ', '-')
  end

  attr_reader :directory, :filepath
end
