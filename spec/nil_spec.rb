# frozen_string_literal: true

require 'spec_helper'

describe NilClass do
  it 'has a nil count' do
    expect(nil.count).to be nil
  end

  it 'has a nil first' do
    expect(nil.first).to be nil
  end

  it 'has a nil last' do
    expect(nil.first).to be nil
  end

  it 'is not `false?`' do
    expect(nil.false?).to be false
  end

  it 'is `empty?`' do
    expect(nil.empty?).to be true
  end

  it 'is not `present?`' do
    expect(nil.present?).to be false
  end

  it 'is `blank?`' do
    expect(nil.blank?).to be true
  end

  it 'is not `true?`' do
    expect(nil.true?).to be false
  end

  it 'is `falsy?`' do
    expect(nil.falsy?).to be true
  end

  it 'is not `truthy?`' do
    expect(nil.truthy?).to be false
  end

  it 'return `false` for `to_bool' do
    expect(nil.to_bool).to be false
  end
end
