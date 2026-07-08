# frozen_string_literal: true

require 'spec_helper'

describe File do
  context 'using built-in `exist?` method' do
    it 'is truthy when the file exists' do
      expect(File.exist?(__FILE__)).to be true
    end

    it 'is falsy when the file does not exist' do
      expect(File.exist?('something-that-does-not-exist')).to be false
    end
  end

  context 'using original `exists?` method' do
    it 'is available as a class method' do
      expect(File).to respond_to(:exists?)
    end

    it 'is truthy when the file exists' do
      expect(File.exists?(__FILE__)).to be true
    end

    it 'is falsy when the file does not exist' do
      expect(File.exists?('something-that-does-not-exist')).to be false
    end

    it 'agrees with `exist?`' do
      expect(File.exists?(__FILE__)).to eq(File.exist?(__FILE__))
      expect(File.exists?('missing-file')).to eq(File.exist?('missing-file'))
    end
  end
end
