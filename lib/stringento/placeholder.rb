# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Stringento
  # A placeholder is a to-be-resolved-and-formatted token within a string.
  # A placeholder has a minimum one part and at maximum three parts (token::formatter:argument),
  # for example:
  # - first_name
  # - first_name::capitalize
  # - dob::date::mm-dd-yyyy
  class Placeholder
    SEPARATOR = '::'

    attr_reader :arg, :formatter, :name, :value

    def initialize(value)
      @value = value.to_s

      parts = @value.split(SEPARATOR)
      count = parts.length

      raise ArgumentError, "Cannot be split: #{value}" if count.negative? || count > 3

      @name       = parts[0] || ''
      @formatter  = parts[1] || ''
      @arg        = parts[2] || ''

      freeze
    end
  end
end
