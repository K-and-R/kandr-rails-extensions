# frozen_string_literal: true

require 'spec_helper'

describe FalseClass do
  context 'using FalseFalse' do
    it 'is `false?`' do
      expect(false.false?).to be true
    end

    it 'is `falsy?`' do
      expect(false.falsy?).to be true
    end

    it 'is not `true?`' do
      expect(false.true?).to be false
    end

    it 'is not `truthy?`' do
      expect(false.truthy?).to be false
    end

    it 'returns itself from `to_bool`' do
      expect(false.to_bool).to be false
      expect(false.to_bool).to be(false)
    end

    it 'works with values converted via `to_bool`' do
      expect(0.to_bool.false?).to be true
      expect(1.to_bool.false?).to be false
    end
  end
end
