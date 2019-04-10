# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Stringento
  # Base class / base implementation of a formatter.
  # In order to customize formatting:
  # - Derive subclass
  # - Implement formatter methods ending in: _formatter.
  # - Pass instance into into Stringento#evaluate
  class Formatter
    METHOD_SUFFIX = '_formatter'

    private_constant :METHOD_SUFFIX

    def formatter(method, value, arg = '')
      method_name = "#{method}#{METHOD_SUFFIX}"

      if respond_to?(method_name)
        send(method_name, value, arg)
      else
        value.to_s
      end
    end
  end
end
