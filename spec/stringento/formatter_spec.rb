# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'
require './spec/examples/custom_formatter'

describe ::Stringento::Formatter do
  describe 'when not specifying a method' do
    it 'should return value as a string' do
      method = ''
      value  = 'some value'
      actual = described_class.new.formatter(method, value)

      expect(actual).to eq(value)
    end
  end

  describe 'when specifying a formatter that does not exist' do
    it 'should return value as a string' do
      method = 'doesnt_exist'
      value  = 'some value'
      actual = described_class.new.formatter(method, value)

      expect(actual).to eq(value)
    end
  end

  describe 'custom formatters' do
    it 'yes_no formatter should be called' do
      formatter = CustomFormatter.new
      method    = 'yes_no'

      expect(formatter.formatter(method, true)).to    eq('Yes')
      expect(formatter.formatter(method, 'true')).to  eq('Yes')
      expect(formatter.formatter(method, '')).to      eq('Yes')
      expect(formatter.formatter(method, 'false')).to eq('Yes')

      expect(formatter.formatter(method, false)).to   eq('No')
      expect(formatter.formatter(method, nil)).to     eq('No')
    end
  end

  it 'yes_no_unknown formatter should be called' do
    formatter = CustomFormatter.new
    method = 'yes_no_unknown'

    expect(formatter.formatter(method, true)).to    eq('Yes')
    expect(formatter.formatter(method, 'true')).to  eq('Yes')
    expect(formatter.formatter(method, '')).to      eq('Yes')
    expect(formatter.formatter(method, 'false')).to eq('Yes')

    expect(formatter.formatter(method, false)).to   eq('No')

    expect(formatter.formatter(method, nil)).to     eq('Unknown')
  end
end
