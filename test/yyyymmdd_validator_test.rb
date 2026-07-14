# frozen_string_literal: true

require 'test_helper'

class YyyymmddValidatorTest < Minitest::Test
  class ModelWithYyyyMmDd
    include ActiveModel::Validations

    attr_accessor :yyyymmdd

    validates :yyyymmdd, yyyymmdd: true
  end

  def test_date_starting_with_zero_should_not_trick_validator
    yyyymmdd_model = ModelWithYyyyMmDd.new
    yyyymmdd_model.yyyymmdd = '020221114'

    refute_predicate yyyymmdd_model, :valid?, '020221114 should be invalid'
    assert_predicate yyyymmdd_model.errors[:yyyymmdd], :present?, 'should have a yyyymmdd error'
  end

  def test_valid_yyyymmdd_values_should_be_valid
    yyyymmdd_model = ModelWithYyyyMmDd.new
    yyyymmdd_model.yyyymmdd = 20140101

    assert_predicate yyyymmdd_model, :valid?, '20140101 should be valid'
    assert_predicate yyyymmdd_model.errors, :empty?, "shouldn't have any errors"
  end

  def test_properly_formatted_but_invalid_date_yyyymmdds_are_not_valid
    yyyymmdd_model = ModelWithYyyyMmDd.new
    yyyymmdd_model.yyyymmdd = 20140141

    refute_predicate yyyymmdd_model, :valid?, '20140141 should be invalid'
    assert_predicate yyyymmdd_model.errors[:yyyymmdd], :present?, 'should have a yyyymmdd error'
  end

  def test_horribly_wrong_yyyymmdds_are_not_valid
    yyyymmdd_model = ModelWithYyyyMmDd.new
    yyyymmdd_model.yyyymmdd = 9_304_578_290_387_520_934_578

    refute_predicate yyyymmdd_model, :valid?, '9304578290387520934578 should be invalid'
    assert_predicate yyyymmdd_model.errors[:yyyymmdd], :present?, 'should have a yyyymmdd error'
  end

  def test_valid_string_yyyymmdd_values_are_not_valid
    yyyymmdd_model = ModelWithYyyyMmDd.new
    yyyymmdd_model.yyyymmdd = '20140101'

    refute_predicate yyyymmdd_model, :valid?, "'20140101' should be invalid"
    assert_predicate yyyymmdd_model.errors[:yyyymmdd], :present?, 'should have a yyyymmdd error'
  end
end
