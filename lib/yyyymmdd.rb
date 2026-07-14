# frozen_string_literal: true

require 'active_support'
require 'active_support/time'
require 'active_support/core_ext/date/conversions'
require 'active_support/core_ext/date_time/conversions'

require_relative 'yyyymmdd/version'
require_relative 'yyyymmdd/date_extensions'
require_relative 'yyyymmdd/time_extensions'
require_relative 'yyyymmdd/validation'
require_relative 'yyyymmdd/validator'
require_relative 'yyyymmdd/range'
require_relative 'yyyymmdd/helpers'

# Integer calendar-day encoding (YYYYMMDD) and related compact date/time formats.
#
# Core APIs (also monkey-patched onto Date / Time for drop-in compatibility):
#
#   Date.current.yyyymmdd            #=> 20240714
#   Date.from_yyyymmdd(20240714)     #=> #<Date ...>
#   Time.now.yyyymmddhhmmss          #=> 20240714153000
#   Time.from_hhmm(1055)             #=> #<Time ... 10:55>
#   Yyyymmdd.valid?(20240714)        #=> true
#   Yyyymmdd.between(20240701, 20240703)
#
# ActiveModel:
#
#   validates :yyyymmdd, yyyymmdd: true
module Yyyymmdd
end
