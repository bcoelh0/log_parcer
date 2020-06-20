# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:all, &:silence_output)
end

public
# Redirects stderr and stout to /dev/null.txt
def silence_output
  # Store the original stderr and stdout in order to restore them later
  @original_stderr = $stderr
  @original_stdout = $stdout

  # Redirect stderr and stdout
  $stderr = File.new(File.join(File.dirname(__FILE__), "stdout", "null.txt"), "w")
  $stdout = File.new(File.join(File.dirname(__FILE__), "stdout", "null.txt"), "w")
end
