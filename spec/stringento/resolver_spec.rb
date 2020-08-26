# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'
require './spec/examples/custom_formatter'

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

describe Stringento::Resolver do
  context 'input is hash' do
    let(:input) do
      {
        name: 'Matt'
      }
    end

    it 'should resolve for existing key' do
      expect(described_class.new.resolve(:name, input)).to eq(input[:name])
    end

    it 'should resolve nil for missing key' do
      expect(described_class.new.resolve(:doesnt_exist, input)).to eq(nil)
    end
  end

  context 'input is null' do
    let(:input) { nil }

    it 'should resolve to null' do
      expect(described_class.new.resolve(:name, input)).to eq(nil)
    end
  end

  context 'input is an object' do
    let(:input) { Person.new('Matt') }

    it 'should resolve to null' do
      expect(described_class.new.resolve(:name, input)).to eq(input.name)
    end
  end
end
