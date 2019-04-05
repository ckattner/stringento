# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Stringento
  # This is the base class / implementation for how values are resolved.
  # In order to change this:
  # - Derive a subclass
  # - Override the #resolve method
  # - Pass instance into into Stringento#evaluate
  class Resolver
    def resolve(value, input)
      if input&.respond_to?(:[])
        input[value]
      elsif input&.respond_to?(value)
        input.send(value)
      end
    end
  end
end
