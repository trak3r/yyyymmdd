# frozen_string_literal: true

require 'test_helper'

class TimeExtensionsTest < Minitest::Test
  def test_yyyymmdd_delegates_to_date
    time = Time.utc(2015, 5, 30, 10, 55, 0)
    assert_equal 20150530, time.yyyymmdd
  end

  def test_yyyymmddhhmmss
    time = Time.utc(2015, 5, 30, 10, 55, 12)
    assert_equal 20150530105512, time.yyyymmddhhmmss

    parsed = Time.from_yyyymmddhhmmss(20150530105512)
    assert_equal 2015, parsed.year
    assert_equal 5, parsed.month
    assert_equal 30, parsed.day
    assert_equal 10, parsed.hour
    assert_equal 55, parsed.min
    assert_equal 12, parsed.sec
  end

  def test_from_yyyymmddhhmmss_returns_nil_for_nil
    assert_nil Time.from_yyyymmddhhmmss(nil)
  end

  def test_hhmm_converts_time_to_integer
    time1 = Time.zone.local(2015, 5, 30, 1, 0, 0)
    time2 = Time.zone.local(2015, 5, 30, 10, 55, 0)
    time3 = Time.zone.local(2015, 5, 30, 0, 0, 0)

    assert_equal 100, time1.hhmm
    assert_equal 1055, time2.hhmm
    assert_equal 0, time3.hhmm
  end

  def test_hhmm_converts_integer_to_time
    time1 = Time.current.change(hour: 1, min: 0)
    time2 = Time.current.change(hour: 10, min: 55)
    time3 = Time.current.change(hour: 0, min: 0)

    parsed_time1 = Time.from_hhmm(100)
    parsed_time2 = Time.from_hhmm(1055)
    parsed_time3 = Time.from_hhmm(0)

    assert_equal time1.hour, parsed_time1.hour
    assert_equal time1.min, parsed_time1.min

    assert_equal time2.hour, parsed_time2.hour
    assert_equal time2.min, parsed_time2.min

    assert_equal time3.hour, parsed_time3.hour
    assert_equal time3.min, parsed_time3.min
  end

  def test_from_hhmm_returns_nil_for_nil
    assert_nil Time.from_hhmm(nil)
  end

  def test_datetime_epoch
    epoch = Time.datetime_epoch
    assert_equal 1970, epoch.year
    assert_equal 1, epoch.month
    assert_equal 1, epoch.day
  end
end
