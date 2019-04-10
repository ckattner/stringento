# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Stringento
  # This is the main rendering engine for the library.  It connects together the notions of:
  # parsing, value resolution, and value formatting in a consumable way.
  class Template
    TOKEN_REGULAR_EXPRESSION = /{(.*?)}/.freeze

    private_constant :TOKEN_REGULAR_EXPRESSION

    attr_reader :value

    def initialize(value)
      @value = value.to_s
    end

    def placeholders
      @placeholders ||= value.scan(TOKEN_REGULAR_EXPRESSION)
                             .flatten
                             .map { |str| Placeholder.new(str) }
    end

    def evaluate(input, resolver: Resolver.new, formatter: Formatter.new)
      placeholders.inject(value) do |output, placeholder|
        resolved_value = (resolver || default_resolver).resolve(placeholder.name, input)

        formatted_value = (formatter || default_formatter).formatter(
          placeholder.formatter,
          resolved_value,
          placeholder.arg
        )

        output.gsub("{#{placeholder.value}}", formatted_value)
      end
    end
  end
end
