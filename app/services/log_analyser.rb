# frozen_string_literal: true

# Responsible for calculating the number of visits per path
class LogAnalyser
  attr_reader :log_entries

  def initialize(log_entries:)
    @log_entries = log_entries
  end

  def visit_count
    grouped_visits = group_ip_by_path
    # sort in descending order
    count_visits(grouped_visits).sort_by { |v| v[:visits] }.reverse
  end

  def unique_visit_count
    # group all IP addresses by path, then remove duplicates
    grouped_visits = group_ip_by_path.each { |ele| ele[:visits].uniq! }
    # sort in descending order
    count_visits(grouped_visits).sort_by { |v| v[:visits] }.reverse
  end

  private

  def group_ip_by_path
    grouped_visits = []
    log_entries.each do |entry|
      if (path_visited = find_entry_in_array(grouped_visits, entry))
        path_visited[:visits] << entry.ip_address
      else
        grouped_visits << { path: entry.path, visits: [entry.ip_address] }
      end
    end
    grouped_visits
  end

  def count_visits(visits_arr)
    visits_arr.map do |v|
      { path: v[:path], visits: v[:visits].count }
    end
  end

  def find_entry_in_array(visits_arr, entry)
    visits_arr.find { |v| v[:path] == entry.path }
  end
end
