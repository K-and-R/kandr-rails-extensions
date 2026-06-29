# frozen_string_literal: true

require 'spec_helper'

describe File do
  context 'using new `exist?` method' do
    it 'if truthy when the file exists' do
      expect(
        File.exist? __FILE__
      ).to be true
    end

    it 'if falsy when the file does not exist' do
      expect(
        File.exist? 'something-that-does-not-exist'
      ).to be false
    end
  end

  context 'using original `exists?` method' do
    it 'if truthy when the file exists' do
      expect(
        File.exists? __FILE__
      ).to be true
    end

    it 'if falsy when the file does not exist' do
      expect(
        File.exists? 'something-that-does-not-exist'
      ).to be false
    end
  end
end
