# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'stringento/formatter'
require_relative 'stringento/placeholder'
require_relative 'stringento/resolver'
require_relative 'stringento/template'

# Top-level API for main external consumption.  It is better to use this than instantiating
# your own Template objects because this top-level object will cache Template objects based
# on the expression.  It also provides less default resolver and formatter instantiations.
module Stringento
  class << self
    def evaluate(expression, input, resolver: nil, formatter: nil)
      template(expression).evaluate(
        input,
        resolver: (resolver || default_resolver),
        formatter: (formatter || default_formatter)
      )
    end

    private

    def templates
      @templates ||= {}
    end

    def template(expression)
      templates[expression.to_s] ||= Template.new(expression)
    end

    def default_resolver
      @default_resolver ||= Resolver.new
    end

    def default_formatter
      @default_formatter ||= Formatter.new
    end
  end
end
