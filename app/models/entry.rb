# frozen_string_literal: true

# Represents each entry in the log file (each row)
class Entry
  attr_accessor :path, :ip_address

  def initialize(path:, ip_address:)
    @path = path
    @ip_address = ip_address
  end
end
