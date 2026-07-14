# frozen_string_literal: true

require 'test_helper'

class RangeTest < Minitest::Test
  def test_between_inclusive
    assert_equal [20240701, 20240702, 20240703], Yyyymmdd.between(20240701, 20240703)
  end

  def test_between_defaults_end_to_seven_days
    assert_equal 8, Yyyymmdd.between(20240701).size
    assert_equal 20240701, Yyyymmdd.between(20240701).first
    assert_equal 20240708, Yyyymmdd.between(20240701).last
  end

  def test_between_defaults_start_to_current
    travel_to Date.new(2024, 7, 14) do
      assert_equal Date.current.yyyymmdd, Yyyymmdd.between(nil, nil).first
    end
  end
end
