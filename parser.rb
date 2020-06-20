# frozen_string_literal: true

require "./app/app.rb"

if App.main(ARGV.first)
  exit 0
else
  exit(-1)
end
