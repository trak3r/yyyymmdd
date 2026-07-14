# frozen_string_literal: true

require 'active_model'

# ActiveModel validator: `validates :yyyymmdd, yyyymmdd: true`
#
# Originally lived in app/validators/yyyymmdd_validator.rb
class YyyymmddValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :invalid) unless YyyymmddValidator.valid_yyyymmdd?(value)
  end

  def self.valid_yyyymmdd?(value)
    Yyyymmdd.valid_yyyymmdd?(value)
  end
end
