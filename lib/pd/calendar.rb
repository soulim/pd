# frozen_string_literal: true

require "date"
require "forwardable"

module PD
  class Calendar
    class Entry
      attr_reader :type

      extend Forwardable

      def_delegators :@date, :year,
                             :month,
                             :mday,
                             :cwday

      def initialize(date:, type: nil)
        @date = date
        @type = type
      end
    end

    attr_reader :entries

    def initialize(entries: [])
      @entries = entries
    end

    def self.build(year:, month:, holidays: [], half_holidays: [])
      start_date = Date.new(year, month, 1)
      end_date = Date.new(year, month, -1)

      entries = start_date.step(end_date).map do |date|
        type = entry_type(date: date,
                          holidays: holidays,
                          half_holidays: half_holidays)

        Entry.new(date: date,
                  type: type)
      end

      new(entries: entries)
    end

    # TYPE                  DAY                     =>  NEXT
    # ----------------------------------------------------------
    # WEEK-HOL           -  Weekday                 =>  Holiday
    # SAT-HOL            -  Saturday                =>  Holiday
    # SUN-HOL            -  Sunday                  =>  Holiday
    # HOL-WEEK           -  Holiday                 =>  Weekday
    # HOL-SAT            -  Holiday                 =>  Saturday
    # HOL-SUN            -  Holiday                 =>  Sunday
    # HOL-HOL            -  Holiday                 =>  Holiday
    # WEEK-HALFHOL-HOL   -  Half-Holiday (Weekday)  =>  Holiday
    # SAT-HALFHOL-HOL    -  Half-Holiday (Saturday) =>  Holiday
    # SUN-HALFHOL-HOL    -  Half-Holiday (Sunday)   =>  Holiday
    def self.entry_type(date:, holidays: [], half_holidays: [])
      next_date = date + 1

      if holidays.include?(date) # if current date is a holiday
        if holidays.include?(next_date)
          'HOL-HOL'
        elsif next_date.saturday?
          'HOL-SAT'
        elsif next_date.sunday?
          'HOL-SUN'
        else
          'HOL-WEEK'
        end
      elsif half_holidays.include?(date) # if current date is a half-holiday
        if date.saturday?
          'SAT-HALFHOL-HOL'
        elsif date.sunday?
          'SUN-HALFHOL-HOL'
        else
          'WEEK-HALFHOL-HOL'
        end
      elsif date.saturday? # if current date is Saturday
        if holidays.include?(next_date)
          'SAT-HOL'
        end
      elsif date.sunday? # if current date is Sunday
        if holidays.include?(next_date)
          'SUN-HOL'
        end
      else # current date is a weekday
        if holidays.include?(next_date)
          'WEEK-HOL'
        end
      end
    end
  end
end
