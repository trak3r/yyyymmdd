# frozen_string_literal: true

require 'test_helper'

class DateExtensionsTest < Minitest::Test
  def test_yyyymmdd_converts_date_to_integer
    assert_equal 20140101, Date.new(2014, 1, 1).yyyymmdd
    assert_equal 20240714, Date.new(2024, 7, 14).yyyymmdd
  end

  def test_from_yyyymmdd_parses_integer
    assert_equal Date.new(2014, 1, 1), Date.from_yyyymmdd(20140101)
  end

  def test_from_yyyymmdd_parses_string
    assert_equal Date.new(2014, 1, 1), Date.from_yyyymmdd('20140101')
  end

  def test_from_yyyymmdd_returns_nil_for_nil
    assert_nil Date.from_yyyymmdd(nil)
  end

  def test_round_trip
    date = Date.new(2020, 2, 29)
    assert_equal date, Date.from_yyyymmdd(date.yyyymmdd)
  end

  def test_yearweek
    date = Date.new(2024, 7, 14)
    assert_equal date.strftime('%Y%W').to_i, date.yearweek
    assert_equal Date.strptime(date.yearweek.to_s, '%Y%W'), Date.from_yearweek(date.yearweek)
  end

  def test_from_yearweek_returns_nil_for_nil
    assert_nil Date.from_yearweek(nil)
  end

  def test_for_datetime_column_is_utc_midnight
    date = Date.new(2015, 5, 30)
    time = date.for_datetime_column

    assert_equal 2015, time.year
    assert_equal 5, time.month
    assert_equal 30, time.day
    assert_equal 0, time.hour
    assert_equal 0, time.min
    assert_equal 0, time.sec
    assert_equal 0, time.utc_offset
  end

  def test_date_of_next_uses_parse_relative_to_today
    # Matches original monkey-patch semantics: Date.parse(dow) is relative to
    # today, then shifted by ±7 if that day is not after +self+.
    base = Date.new(2000, 1, 1)
    expected = begin
      date = Date.parse('sunday')
      delta = date > base ? 0 : 7
      date + delta
    end

    assert_equal expected, base.date_of_next(:sunday)
  end

  def test_date_of_last_uses_parse_relative_to_today
    base = Date.new(2099, 1, 1)
    expected = begin
      date = Date.parse('monday')
      delta = date < base ? 0 : 7
      date - delta
    end

    assert_equal expected, base.date_of_last(:monday)
  end

  def test_date_of_next_class_method_delegates_to_current
    travel_to Date.new(2024, 7, 8) do
      assert_equal Date.current.date_of_next(:sunday), Date.date_of_next(:sunday)
    end
  end
end
