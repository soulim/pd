# frozen_string_literal: true

require "minitest/autorun"
require "minitest/test"

require_relative "../lib/pd/calendar"

class TestCalendar < Minitest::Test
  HOLIDAYS = [
    Date.new(2024, 11, 4),
    Date.new(2024, 12, 3),
    Date.new(2024, 12, 4),
    Date.new(2024, 12, 8),
    Date.new(2024, 12, 13),
    Date.new(2024, 12, 16),
    Date.new(2024, 12, 21),
    Date.new(2024, 12, 25),
  ]
  HALF_HOLIDAYS = [
    Date.new(2024, 11, 3),
    Date.new(2024, 12, 24),
    Date.new(2024, 12, 28),
  ]

  def setup
    @year = 2024
    @month = 12
  end

  def test_self_build_to_return_calendar_for_given_year
    calendar = PD::Calendar.build(year: @year,
                                  month: @month,
                                  holidays: HOLIDAYS,
                                  half_holidays: HALF_HOLIDAYS)
    same_year = calendar.entries.all? { |entry| entry.year == @year }

    assert(same_year)
  end

  def test_self_build_to_return_calendar_for_given_month
    calendar = PD::Calendar.build(year: @year,
                                  month: @month,
                                  holidays: HOLIDAYS,
                                  half_holidays: HALF_HOLIDAYS)
    same_month = calendar.entries.all? { |entry| entry.month == @month }

    assert(same_month)
  end

  def test_self_build_to_assign_types_to_calendar_entries
    calendar = PD::Calendar.build(year: @year,
                                  month: @month,
                                  holidays: HOLIDAYS,
                                  half_holidays: HALF_HOLIDAYS)
    some_types = calendar.entries.any? { |entry| !entry.type.nil? }

    assert(some_types)
  end

  def test_self_entry_type_with_weekday_to_holiday
    type = PD::Calendar.entry_type(date: Date.new(2024, 12, 2),
                                   holidays: HOLIDAYS,
                                   half_holidays: HALF_HOLIDAYS)

    assert_equal('WEEK-HOL', type)
  end

  def test_self_entry_type_with_saturday_to_holiday
    type = PD::Calendar.entry_type(date: Date.new(2024, 12, 7),
                                   holidays: HOLIDAYS,
                                   half_holidays: HALF_HOLIDAYS)

    assert_equal('SAT-HOL', type)
  end

  def test_self_entry_type_with_sunday_to_holiday
    type = PD::Calendar.entry_type(date: Date.new(2024, 12, 15),
                                   holidays: HOLIDAYS,
                                   half_holidays: HALF_HOLIDAYS)

    assert_equal('SUN-HOL', type)
  end

  def test_self_entry_type_with_holiday_to_weekday
    type = PD::Calendar.entry_type(date: Date.new(2024, 12, 16),
                                   holidays: HOLIDAYS,
                                   half_holidays: HALF_HOLIDAYS)

    assert_equal('HOL-WEEK', type)
  end

  def test_self_entry_type_with_holiday_to_saturday
    type = PD::Calendar.entry_type(date: Date.new(2024, 12, 13),
                                   holidays: HOLIDAYS,
                                   half_holidays: HALF_HOLIDAYS)

    assert_equal('HOL-SAT', type)
  end

  def test_self_entry_type_with_holiday_to_sunday
    type = PD::Calendar.entry_type(date: Date.new(2024, 12, 21),
                                   holidays: HOLIDAYS,
                                   half_holidays: HALF_HOLIDAYS)

    assert_equal('HOL-SUN', type)
  end

  def test_self_entry_type_with_holiday_to_holiday
    type = PD::Calendar.entry_type(date: Date.new(2024, 12, 3),
                                   holidays: HOLIDAYS,
                                   half_holidays: HALF_HOLIDAYS)

    assert_equal('HOL-HOL', type)
  end

  def test_self_entry_type_with_halfholiday_weekday_to_holiday
    type = PD::Calendar.entry_type(date: Date.new(2024, 12, 24),
                                   holidays: HOLIDAYS,
                                   half_holidays: HALF_HOLIDAYS)

    assert_equal('WEEK-HALFHOL-HOL', type)
  end

  def test_self_entry_type_with_halfholiday_saturday_to_holiday
    type = PD::Calendar.entry_type(date: Date.new(2024, 12, 28),
                                   holidays: HOLIDAYS,
                                   half_holidays: HALF_HOLIDAYS)

    assert_equal('SAT-HALFHOL-HOL', type)
  end

  def test_self_entry_type_with_halfholiday_sunday_to_holiday
    type = PD::Calendar.entry_type(date: Date.new(2024, 11, 3),
                                   holidays: HOLIDAYS,
                                   half_holidays: HALF_HOLIDAYS)

    assert_equal('SUN-HALFHOL-HOL', type)
  end
end
