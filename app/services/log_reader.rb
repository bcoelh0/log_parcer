# frozen_string_literal: true

# Responsible for turning log data into Entry objects
class LogReader
  attr_reader :file_path

  def initialize(file_path:)
    @file_path = file_path
  end

  def build_entries
    file_to_array.map do |raw_entry|
      Entry.new(path: raw_entry[0], ip_address: raw_entry[1])
    end
  end

  private

  def file_to_array
    read_file.split("\n").map do |row|
      row.split(" ")
    end
  end

  def read_file
    File.read(File.join(File.dirname(__FILE__), "../../", file_path))
  end
end
