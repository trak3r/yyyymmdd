# frozen_string_literal: true

require 'test_helper'

class ValidationTest < Minitest::Test
  def test_validate_bang_allows_nil
    assert_nil Yyyymmdd.validate!(nil)
  end

  def test_validate_bang_accepts_eight_digit_string
    assert_nil Yyyymmdd.validate!('20140101')
  end

  def test_validate_bang_accepts_integer
    assert_nil Yyyymmdd.validate!(20140101)
  end

  def test_validate_bang_rejects_empty_string
    assert_raises(ArgumentError) { Yyyymmdd.validate!('') }
  end

  def test_validate_bang_rejects_leading_zero
    assert_raises(ArgumentError) { Yyyymmdd.validate!('020140101') }
  end

  def test_validate_bang_rejects_non_digits
    assert_raises(ArgumentError) { Yyyymmdd.validate!('2014-01-01') }
  end

  def test_validate_bang_rejects_wrong_length
    assert_raises(ArgumentError) { Yyyymmdd.validate!('2014010') }
  end

  def test_validate_bang_rejects_newline_padded
    assert_raises(ArgumentError) { Yyyymmdd.validate!("20140101\n") }
  end

  def test_valid_predicate
    assert Yyyymmdd.valid?(20140101)
    refute Yyyymmdd.valid?('020140101')
  end

  def test_valid_yyyymmdd_round_trip_requires_matching_type
    assert Yyyymmdd.valid_yyyymmdd?(20140101)
    refute Yyyymmdd.valid_yyyymmdd?('20140101')
  end

  def test_helpers_mixin
    obj = Object.new.extend(Yyyymmdd::Helpers)
    assert_nil obj.validate_yyyymmdd!(20140101)
    assert_raises(ArgumentError) { obj.validate_yyyymmdd!('bad') }
  end
end
