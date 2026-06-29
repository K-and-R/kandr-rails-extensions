# frozen_string_literal: true

require 'spec_helper'

describe Date do
  it 'matches `before?` for a previous date' do
    expect(Date.today.before?(Date.tomorrow)).to be true
  end

  it 'does not match `before?` for a future date' do
    expect(Date.today.before?(Date.yesterday)).to be false
  end

  it 'does not match `before?` for same date' do
    expect(Date.today.before?(Date.today)).to be false
  end

  it 'matches `after?` for a previous date' do
    expect(Date.today.after?(Date.yesterday)).to be true
  end

  it 'does not match `after?` for a future date' do
    expect(Date.today.after?(Date.tomorrow)).to be false
  end

  it 'does not match `after?` for same date' do
    expect(Date.today.after?(Date.today)).to be false
  end

  it 'matches today `on_or_before?` for same or future date' do
    expect(Date.today.on_or_before?(Date.today)).to be true
    expect(Date.today.on_or_before?(Date.tomorrow)).to be true
  end

  it 'matches today `on_or_before?` for same or future date' do
    expect(Date.today.on_or_before?(Date.today)).to be true
    expect(Date.today.on_or_before?(Date.tomorrow)).to be true
  end

  it 'matches `after?` future date' do
    expect(Date.today.before?(Date.today, true)).to be true
  end
end
