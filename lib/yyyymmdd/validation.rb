# frozen_string_literal: true

module Yyyymmdd
  # Param / value guards for YYYYMMDD integers (and string forms that look like them).
  #
  # Extracted from CustomValidators#validate_yyyymmdd! in the services app.
  module Validation
    module_function

    # Raises if +val+ is present but not a valid 8-digit YYYYMMDD (no leading zero).
    # Returns nil when +val+ is nil (absent params are allowed).
    def validate!(val)
      return unless val

      # can't be an empty string
      raise ArgumentError, 'is not a valid date' if val.to_s.empty?

      # Date.parse / from_yyyymmdd can strip bad characters via to_i semantics;
      # callers often pass the raw string into SQL, so require exactly 8 digits.
      raise ArgumentError, 'is not a valid date' unless val.to_s.match?(/^\d{8}$/)

      # the regex (above) is fooled by newline characters
      raise ArgumentError, 'is not a valid date' unless val.to_s.length == 8

      # date can't start with zero
      raise ArgumentError, 'is not a valid date' if val.to_s.start_with?('0')

      # must convert
      raise ArgumentError, 'is not a valid date' if Date.from_yyyymmdd(val).nil?
    end

    def valid?(val)
      validate!(val)
      true
    rescue StandardError
      false
    end

    # Round-trip check used by the ActiveModel validator: value must encode back
    # to the same object (so String "20140101" is invalid when Integer is expected).
    def valid_yyyymmdd?(value)
      Date.from_yyyymmdd(value).yyyymmdd == value
    rescue StandardError
      false
    end
  end

  class << self
    def validate!(val) = Validation.validate!(val)
    def valid?(val) = Validation.valid?(val)
    def valid_yyyymmdd?(value) = Validation.valid_yyyymmdd?(value)
  end
end
