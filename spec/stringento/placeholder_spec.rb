# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe ::Stringento::Placeholder do
  let(:tests) do
    [
      [
        '',
        {
          arg: '',
          formatter: '',
          name: '',
          value: ''
        }
      ],
      [
        nil,
        {
          arg: '',
          formatter: '',
          name: '',
          value: ''
        }
      ],
      [
        1,
        {
          arg: '',
          formatter: '',
          name: '1',
          value: '1'
        }
      ],
      [
        false,
        {
          arg: '',
          formatter: '',
          name: 'false',
          value: 'false'
        }
      ],
      [
        'string-value',
        {
          arg: '',
          formatter: '',
          name: 'string-value',
          value: 'string-value'
        }
      ],
      [
        'dob::date::short',
        {
          arg: 'short',
          formatter: 'date',
          name: 'dob',
          value: 'dob::date::short'
        }
      ],
      [
        'created_at::time_ago',
        {
          arg: '',
          formatter: 'time_ago',
          name: 'created_at',
          value: 'created_at::time_ago'
        }
      ]
    ]
  end

  it 'should properly initialize attributes' do
    tests.each do |test|
      expression      = test.first
      expected_values = test.last

      placeholder = described_class.new(expression)

      expect(placeholder.arg).to        eq(expected_values[:arg])
      expect(placeholder.formatter).to  eq(expected_values[:formatter])
      expect(placeholder.name).to       eq(expected_values[:name])
      expect(placeholder.value).to      eq(expected_values[:value])
    end
  end
end
