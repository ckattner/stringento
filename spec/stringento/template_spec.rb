# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'
require './spec/examples/custom_formatter'
require './spec/examples/indifferent_hash_resolver'

describe Stringento::Template do
  describe '#placeholders' do
    let(:tests) do
      [
        [
          '',
          []
        ],
        [
          nil,
          []
        ],
        [
          1,
          []
        ],
        [
          false,
          []
        ],
        [
          'string with none',
          []
        ],
        [
          '{one {inside} another one}',
          ['one {inside']
        ],
        [
          'matt {is} a {monkeys} uncle.',
          %w[is monkeys]
        ],
        [
          'matt {is::date::short} a {monkeys::timeAgo} uncle.',
          %w[is::date::short monkeys::timeAgo]
        ]
      ]
    end

    it 'should parse' do
      tests.each do |test|
        expression      = test.first
        expected_values = test.last

        template            = described_class.new(expression)
        placeholder_values  = template.placeholders.map(&:value)

        expect(placeholder_values).to eq(expected_values)
      end
    end
  end
end
