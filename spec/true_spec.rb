# frozen_string_literal: true

require 'spec_helper'

describe TrueClass do
  context 'using TrueTrue' do
    it 'is `true?`' do
      expect(true.true?).to be true
    end

    it 'is `truthy?`' do
      expect(true.truthy?).to be true
    end

    it 'is not `false?`' do
      expect(true.false?).to be false
    end

    it 'is not `falsy?`' do
      expect(true.falsy?).to be false
    end

    it 'returns itself from `to_bool`' do
      expect(true.to_bool).to be true
      expect(true.to_bool).to be(true)
    end

    it 'works with values converted via `to_bool`' do
      expect(1.to_bool.true?).to be true
      expect(0.to_bool.true?).to be false
    end
  end
end
