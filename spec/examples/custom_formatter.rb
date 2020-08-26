# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

class CustomFormatter < Stringento::Formatter
  def yes_no_formatter(value, _arg)
    value ? 'Yes' : 'No'
  end

  def yes_no_unknown_formatter(value, _arg)
    if value.nil?
      'Unknown'
    elsif value
      'Yes'
    else
      'No'
    end
  end
end
