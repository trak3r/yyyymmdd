# frozen_string_literal: true

module Yyyymmdd
  # Inclusive range of calendar-day integer keys between two YYYYMMDD values.
  #
  # Pattern used by AbstractLogDaysBroker#yyyymmdds in the services app.
  module Range
    module_function

    # @param start_yyyymmdd [Integer, String, nil]
    # @param end_yyyymmdd [Integer, String, nil]
    # @return [Array<Integer>]
    def between(start_yyyymmdd, end_yyyymmdd = nil)
      start_date = Date.from_yyyymmdd(start_yyyymmdd) || Date.current
      end_date = Date.from_yyyymmdd(end_yyyymmdd) || (start_date + 7).to_date
      (start_date..end_date).map(&:yyyymmdd)
    end
  end

  def self.between(...) = Range.between(...)
end
