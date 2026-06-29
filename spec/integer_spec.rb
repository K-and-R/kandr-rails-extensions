# frozen_string_literal: true

require 'spec_helper'

describe Integer do
  context 'using `to_bool`' do
    it 'is true when not zero' do
      expect(1.to_bool).to be true
      expect(-1.to_bool).to be true
    end

    it 'is false when not zero' do
      expect(0.to_bool).to be false
    end
  end
end
