# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

class IndifferentHashResolver
  def resolve(value = '', input = {})
    input ? (input[value.to_s] || input[value.to_s.to_sym]) : nil
  end
end
