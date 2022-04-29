# frozen_string_literal: true

require "minitest/autorun"

require_relative "../lib/pd/csviser"

module PD
  class TestCSViser < Minitest::Test
    def setup
      @csviser = PD::CSViser.new
    end

    def test_add_list_with_empty_list
      @csviser.add_list([])

      exp = ""
      act = @csviser.to_csv

      assert_equal(exp, act)
    end

    def test_add_list_with_one_item_list
      list = ["1 Alice"]

      @csviser.add_list(list)

      exp = "1,Alice\n"
      act = @csviser.to_csv

      assert_equal(exp, act)
    end

    def test_add_list_with_multi_item_list
      list = ["1 Alice", " 2 Bob D."]

      @csviser.add_list(list)

      exp = "1,Alice\n2,Bob D.\n"
      act = @csviser.to_csv

      assert_equal(exp, act)
    end
  end
end
