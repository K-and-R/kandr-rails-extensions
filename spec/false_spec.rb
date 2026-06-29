# frozen_string_literal: true

require 'spec_helper'

describe FalseClass do
  it 'is `false?`' do
    expect(false.false?).to be true
    expect(0.to_bool.false?).to be true
    expect(!(1.to_bool).false?).to be true
  end

  it 'is not `true?`' do
    expect(false.true?).to be false
  end
end
