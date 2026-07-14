# frozen_string_literal: true

module Yyyymmdd
  # Mixin providing +validate_yyyymmdd!+ with the same name as CustomValidators
  # in the services app (raises +ArgumentError+ instead of a bare RuntimeError).
  #
  #   class MyController
  #     include Yyyymmdd::Helpers
  #     def create
  #       validate_yyyymmdd!(params[:yyyymmdd])
  #     end
  #   end
  module Helpers
    def validate_yyyymmdd!(val)
      Yyyymmdd.validate!(val)
    end
  end
end
