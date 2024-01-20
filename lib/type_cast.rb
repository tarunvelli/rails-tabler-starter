# frozen_string_literal: true

class TypeCast
  FUNCTION_MAPPER = {
    "boolean" => ->(value) { value.to_s.casecmp("true").zero? },
    "string" => ->(value) { value.to_s },
  }.freeze
end
