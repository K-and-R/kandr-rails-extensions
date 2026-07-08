# frozen_string_literal: true

require 'spec_helper'

describe Hash do
  context 'using HashDrop' do
    context 'checking `drop`' do
      it 'returns new clone' do
        hash = {foo: 'foo', bar: 'bar', baz: 'baz'}
		expect(hash.drop(nil)).not_to be(hash)
      end
      it 'removes passed key from clone' do
        hash = {foo: 'foo', bar: 'bar', baz: 'baz'}
        expect(hash.drop(:bar).include?(:bar)).to be_false
        expect(hash.include?(:foo)).to be_true
        expect(hash.include?(:bar)).to be_true
        expect(hash.include?(:baz)).to be_true
      end
      it 'removes passed keys from clone' do
        hash = {foo: 'foo', bar: 'bar', baz: 'baz'}
        expect(hash.drop([:bar, :baz]).include?(:bar)).to be_true
        expect(hash.drop([:bar, :baz]).include?(:baz)).to be_true
        expect(hash.include?(:foo)).to be_true
        expect(hash.include?(:bar)).to be_true
        expect(hash.include?(:baz)).to be_true
      end
    end
    context 'checking `drop!`' do
      it 'returns self' do
        hash = {foo: 'foo', bar: 'bar', baz: 'baz'}
		expect(hash.drop!(nil)).to be(hash)
      end
    end
  end
end
