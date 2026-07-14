# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'yyyymmdd'
require 'minitest/autorun'
require 'active_support/testing/time_helpers'

Time.zone = 'UTC'

class Minitest::Test
  include ActiveSupport::Testing::TimeHelpers
end
