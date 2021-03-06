# frozen_string_literal: true

class HandleSysFiles
  def initialize(directory:, filename:)
    @directory = directory
    @filename = filename
    @filepath = directory + filename
  end

  def file_exists?
    File.exist?(filepath)
  end

  def read_file
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
    Time.current.to_s.gsub(' ', '-')
  end

  attr_reader :directory, :filepath, :filename
end
