# frozen_string_literal: true

require 'time'

# Unusual compact time formats shared across apps (services / interface).
#
# Originally lived in config/initializers/2700_monkey_date.rb
class Time
  YYYYMMDDHHMMSS_FORMAT = '%Y%m%d%H%M%S'

  def yyyymmdd
    to_date.yyyymmdd
  end

  # Integer datetime stamp, e.g. 20240714153000.
  def yyyymmddhhmmss
    Integer(strftime(YYYYMMDDHHMMSS_FORMAT))
  end

  def self.from_yyyymmddhhmmss(value)
    Time.strptime(value.to_s, YYYYMMDDHHMMSS_FORMAT) if value
  end

  # Integer time-of-day, e.g. 1055 for 10:55, 100 for 1:00, 0 for midnight.
  def hhmm
    Integer(strftime('%-H%M'))
  end

  def self.from_hhmm(hhmm)
    Time.strptime(hhmm.to_s.rjust(4, '0'), '%H%M') if hhmm
  end

  # Ruby does not have a Time.epoch method
  def self.datetime_epoch
    Time.zone.local(1970, 1, 1, 0, 0, 0)
  end
end
