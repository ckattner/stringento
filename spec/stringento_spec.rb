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
require './spec/examples/nested_hash_resolver'

describe Stringento do
  context 'without custom formatter and resolver' do
    describe '#evaluate' do
      let(:tests) do
        [
          [
            'matt is a {animal}',
            { 'animal' => 'giraffe' },
            'matt is a giraffe'
          ],
          [
            'matt is a {animal}',
            { animal: 'giraffe' },
            'matt is a '
          ]
        ]
      end

      it 'should evaluate' do
        tests.each do |test|
          expression  = test[0]
          input       = test[1]
          output      = test[2]

          actual = described_class.evaluate(expression, input)

          expect(actual).to eq(output)
        end
      end
    end
  end

  context 'with custom formatter and resolver' do
    describe '#evaluate' do
      let(:tests) do
        [
          [
            'matt is a {animal}',
            { 'animal' => 'giraffe' },
            'matt is a giraffe'
          ],
          [
            'matt is a {animal}',
            { animal: 'giraffe' },
            'matt is a giraffe'
          ],
          [
            '{other} {value} {types} {are} {ok} {bro}',
            {
              are: nil,
              bro: 0,
              ok: nil,
              other: 1,
              types: 12.3,
              value: false
            },
            '1 false 12.3   0'
          ],
          [
            'matt is an elephant: {elephant::yes_no}',
            { elephant: true },
            'matt is an elephant: Yes'
          ],
          [
            'matt is an ostrich: {ostrich::yes_no}',
            { ostrich: false },
            'matt is an ostrich: No'
          ],
          [
            'matt is a cat: {cat::yes_no}',
            { cat: nil },
            'matt is a cat: No'
          ],
          [
            'matt is a bird: {bird::yes_no_unknown}',
            { bird: true },
            'matt is a bird: Yes'
          ],
          [
            'matt is an airplane: {airplane::yes_no_unknown}',
            { airplane: false },
            'matt is an airplane: No'
          ],
          [
            'matt is a dog: {dog::yes_no_unknown}',
            { dog: nil },
            'matt is a dog: Unknown'
          ]
        ]
      end

      let(:resolver) { IndifferentHashResolver.new }

      let(:formatter) { CustomFormatter.new }

      it 'should evaluate' do
        tests.each do |test|
          expression  = test[0]
          input       = test[1]
          output      = test[2]

          actual = described_class.evaluate(
            expression,
            input,
            resolver: resolver,
            formatter: formatter
          )

          expect(actual).to eq(output)
        end
      end
    end
  end

  describe 'README examples' do
    specify 'Getting Started example works' do
      example = 'The {fox_speed} brown fox jumps over the {dog_speed} dog'
      input = { 'fox_speed' => 'quick', 'dog_speed' => 'lazy' }
      result = Stringento.evaluate(example, input)

      expect(result).to eq('The quick brown fox jumps over the lazy dog')
    end

    specify 'Custom Resolution example works' do
      example = 'The {fox.speed} brown fox jumps over the {dog.speed} dog'
      input = { fox: { speed: 'quick' }, dog: { speed: 'lazy' } }

      result = Stringento.evaluate(example, input, resolver: NestedHashResolver.new)

      expect(result).to eq('The quick brown fox jumps over the lazy dog')
    end

    specify 'Custom Formatting example works' do
      example = 'The fox is quick: {fox.quick::yes_no_unknown}'
      input = { fox: { quick: true } }

      result = Stringento.evaluate(
        example,
        input,
        resolver: NestedHashResolver.new,
        formatter: CustomFormatter.new
      )

      expect(result).to eq('The fox is quick: Yes')
    end
  end
end
