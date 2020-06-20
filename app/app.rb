# frozen_string_literal: true

require "./require_all.rb"

# main class
class App
  def self.main(file_path)
    new.main(file_path)
  end

  def main(file_path)
    if file_path.nil?
      puts "Please provide a path top the logs you wish to parse"
      return false
    end

    log_reader = LogReader.new(file_path: file_path)
    begin
      all_entries = log_reader.build_entries
    rescue Errno::ENOENT
      puts "File not found!"
      return false
    end

    log_analyser = LogAnalyser.new(log_entries: all_entries)
    raw_visits = log_analyser.visit_count
    unique_visits = log_analyser.unique_visit_count

    main_print(raw_visits, unique_visits)
    true
  end

  private

  def main_print(raw_visits, unique_visits)
    puts "Number of all page views:"
    print_parsed_results raw_visits, false
    puts
    puts "============================"
    puts
    puts "Number of unique page views:"
    print_parsed_results unique_visits, true
  end

  def print_parsed_results(output_arr, unique)
    max_path_length = output_arr.max_by { |v| v[:path].length }[:path].length
    output_arr.each do |page_visited|
      unique_kw = " unique" if unique
      puts "#{page_visited[:path]}#{([' '] * (max_path_length - page_visited[:path].length)).join} -- #{page_visited[:visits]}#{unique_kw} visits"
    end
  end
end
