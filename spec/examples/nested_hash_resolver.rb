# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

class NestedHashResolver
  def resolve(value, input)
    parts = value.to_s.split('.').map(&:to_sym)

    input ? input.dig(*parts) : nil
  end
end
