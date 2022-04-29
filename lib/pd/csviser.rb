# frozen_string_literal: true

require "csv"

module PD
  class CSViser
    def initialize
      @data = []
    end

    def add_list(lines)
      lines.each_with_index do |line, i|
        # Clean up the line
        line = line.strip
                   .tr("\t", " ")
        # Drop numbers in ont of names
        name = line.split(" ")
                   .drop(1)
                   .join(" ")

        @data[i] ||= [i + 1] # Add date
        @data[i] << name     # Add name
      end
    end

    def to_csv
      CSV.generate do |csv|
        @data.each { |record| csv << record }
      end
    end
  end
end
