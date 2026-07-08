# frozen_string_literal: true

require 'spec_helper'

describe NilClass do
  context 'using NilCount' do
    it 'has a nil count' do
      expect(nil.count).to be_nil
    end

    it 'has a nil first' do
      expect(nil.first).to be_nil
    end

    it 'has a nil last' do
      expect(nil.last).to be_nil
    end
  end

  context 'using NilEmptyOrPresent' do
    it 'is `empty?`' do
      expect(nil.empty?).to be true
    end

    it 'is `blank?`' do
      expect(nil.blank?).to be true
    end

    it 'is not `present?`' do
      expect(nil.present?).to be false
    end

    it 'implements module blank? (may be shadowed by ActiveSupport)' do
      blank = KandrRailsExtensions::NilEmptyOrPresent.instance_method(:blank?)
      expect(blank.bind_call(nil)).to be true
    end
  end

  context 'using NilBoolean' do
    it 'is not `false?`' do
      expect(nil.false?).to be false
    end

    it 'is `falsy?`' do
      expect(nil.falsy?).to be true
    end

    it 'is not `true?`' do
      expect(nil.true?).to be false
    end

    it 'is not `truthy?`' do
      expect(nil.truthy?).to be false
    end

    it 'returns `false` for `to_bool`' do
      expect(nil.to_bool).to be false
    end
  end
end
