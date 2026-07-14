# frozen_string_literal: true

require 'date'

# Unusual compact date formats shared across apps (services / interface).
#
# Originally lived in config/initializers/2700_monkey_date.rb
class Date
  YYYYMMDD_FORMAT = '%Y%m%d'
  YEARWEEK_FORMAT = '%Y%W'

  # Midnight UTC Time suitable for writing into a datetime column.
  def for_datetime_column
    Time.parse("#{to_fs(:db)} 00:00:00 -0000").utc
  end

  # Integer calendar-day key, e.g. 20240714.
  def yyyymmdd
    Integer(strftime(YYYYMMDD_FORMAT))
  end

  # Parse an integer or string YYYYMMDD into a Date. Returns nil when +yyyymmdd+ is nil.
  def self.from_yyyymmdd(yyyymmdd)
    parse(yyyymmdd.to_s) if yyyymmdd
  end

  # Return date of next named day of week (:monday, :sunday, etc.)
  def self.date_of_next(dow)
    Date.current.date_of_next(dow)
  end

  def date_of_next(dow)
    date = Date.parse(dow.to_s)
    delta = date > self ? 0 : 7
    date + delta
  end

  # Return date of last named day of week (:monday, :sunday, etc.)
  def self.date_of_last(dow)
    Date.current.date_of_last(dow)
  end

  def date_of_last(dow)
    date = Date.parse(dow.to_s)
    delta = date < self ? 0 : 7
    date - delta
  end

  # Integer year-week key, e.g. 202428 for week 28 of 2024.
  def yearweek
    Integer(strftime(YEARWEEK_FORMAT))
  end

  def self.from_yearweek(yearweek)
    strptime(yearweek.to_s, YEARWEEK_FORMAT) if yearweek
  end
end
