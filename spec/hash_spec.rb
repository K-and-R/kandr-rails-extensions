# frozen_string_literal: true

require 'spec_helper'

describe Hash do
  context 'using HashDrop' do
    let(:base_hash) { { foo: 'foo', bar: 'bar', baz: 'baz' } }

    context 'checking `drop`' do
      it 'returns a new clone' do
        hash = base_hash.dup
        expect(hash.drop(nil)).not_to be(hash)
      end

      it 'removes a passed key from the clone' do
        hash = base_hash.dup
        result = hash.drop(:bar)

        expect(result.include?(:bar)).to be_false
        expect(result.include?(:foo)).to be_true
        expect(result.include?(:baz)).to be_true

        # original is unchanged
        expect(hash.include?(:foo)).to be_true
        expect(hash.include?(:bar)).to be_true
        expect(hash.include?(:baz)).to be_true
      end

      it 'removes multiple passed keys from the clone' do
        hash = base_hash.dup
        result = hash.drop(:bar, :baz)

        expect(result.include?(:bar)).to be_false
        expect(result.include?(:baz)).to be_false
        expect(result.include?(:foo)).to be_true

        # original is unchanged
        expect(hash.include?(:foo)).to be_true
        expect(hash.include?(:bar)).to be_true
        expect(hash.include?(:baz)).to be_true
      end

      it 'does nothing when dropping a missing key' do
        hash = base_hash.dup
        result = hash.drop(:missing)

        expect(result).to eq(base_hash)
        expect(hash).to eq(base_hash)
      end

      it 'removes keys matching a block' do
        hash = base_hash.dup
        result = hash.drop(:foo, :bar, :baz) { |_h, key| key == :bar }

        expect(result.include?(:bar)).to be_false
        expect(result.include?(:foo)).to be_true
        expect(result.include?(:baz)).to be_true
        expect(hash.include?(:bar)).to be_true
      end

      it 'passes the clone and key to the block' do
        hash = base_hash.dup
        seen_keys = []
        yielded = nil
        result = hash.drop(:foo, :bar) do |h, key|
          yielded = h
          seen_keys << key
          false
        end

        expect(seen_keys).to eq([:foo, :bar])
        expect(yielded).not_to be(hash)
        expect(yielded).to be(result)
      end
    end

    context 'checking `drop!`' do
      it 'returns self' do
        hash = base_hash.dup
        expect(hash.drop!(nil)).to be(hash)
      end

      it 'removes a passed key in place' do
        hash = base_hash.dup
        hash.drop!(:bar)

        expect(hash.include?(:bar)).to be_false
        expect(hash.include?(:foo)).to be_true
        expect(hash.include?(:baz)).to be_true
      end

      it 'removes multiple passed keys in place' do
        hash = base_hash.dup
        hash.drop!(:bar, :baz)

        expect(hash.include?(:bar)).to be_false
        expect(hash.include?(:baz)).to be_false
        expect(hash.include?(:foo)).to be_true
      end

      it 'does nothing when dropping a missing key' do
        hash = base_hash.dup
        hash.drop!(:missing)

        expect(hash).to eq(base_hash)
      end

      it 'removes keys matching a block' do
        hash = base_hash.dup
        hash.drop!(:foo, :bar, :baz) { |_h, key| key.to_s.start_with?('b') }

        expect(hash.include?(:foo)).to be_true
        expect(hash.include?(:bar)).to be_false
        expect(hash.include?(:baz)).to be_false
      end

      it 'keeps keys when the block returns false' do
        hash = base_hash.dup
        hash.drop!(:foo, :bar) { |_h, _key| false }

        expect(hash).to eq(base_hash)
      end

      it 'passes the hash and key to the block' do
        hash = base_hash.dup
        seen = []
        hash.drop!(:foo, :bar) do |h, key|
          seen << [h.object_id, key]
          false
        end

        expect(seen.map(&:last)).to eq([:foo, :bar])
        expect(seen.map(&:first).uniq).to eq([hash.object_id])
      end
    end
  end

  context 'using HashToOstruct' do
    context 'checking `to_ostruct`' do
      it 'converts a flat hash to an OpenStruct' do
        result = { name: 'Ruby', creator: 'Matz' }.to_ostruct

        expect(result).to be_a(OpenStruct)
        expect(result.name).to eq('Ruby')
        expect(result.creator).to eq('Matz')
      end

      it 'recursively converts nested hashes' do
        result = {
          subject: 'Programming Languages',
          language: { name: 'Ruby', creator: 'Matz' }
        }.to_ostruct

        expect(result.subject).to eq('Programming Languages')
        expect(result.language).to be_a(OpenStruct)
        expect(result.language.name).to eq('Ruby')
        expect(result.language.creator).to eq('Matz')
      end

      it 'converts hashes inside arrays' do
        result = {
          languages: [
            { name: 'Ruby', creator: 'Matz' },
            { name: 'Python', creator: 'Guido van Rossum' }
          ]
        }.to_ostruct

        expect(result.languages).to be_an(Array)
        expect(result.languages.size).to eq(2)
        expect(result.languages.first).to be_a(OpenStruct)
        expect(result.languages.first.name).to eq('Ruby')
        expect(result.languages.first.creator).to eq('Matz')
        expect(result.languages.last.name).to eq('Python')
        expect(result.languages.last.creator).to eq('Guido van Rossum')
      end

      it 'leaves non-hash array elements alone' do
        result = { tags: %w[ruby python], numbers: [1, 2, 3] }.to_ostruct

        expect(result.tags).to eq(%w[ruby python])
        expect(result.numbers).to eq([1, 2, 3])
      end

      it 'handles mixed arrays of hashes and other values' do
        result = {
          items: [
            { name: 'Ruby' },
            'plain',
            42
          ]
        }.to_ostruct

        expect(result.items[0]).to be_a(OpenStruct)
        expect(result.items[0].name).to eq('Ruby')
        expect(result.items[1]).to eq('plain')
        expect(result.items[2]).to eq(42)
      end

      it 'converts deeply nested structures' do
        result = {
          outer: {
            middle: {
              inner: { value: 1 }
            }
          }
        }.to_ostruct

        expect(result.outer.middle.inner.value).to eq(1)
      end

      it 'handles an empty hash' do
        result = {}.to_ostruct

        expect(result).to be_a(OpenStruct)
        expect(result.to_h).to eq({})
      end

      it 'preserves string keys as OpenStruct members' do
        result = { 'name' => 'Ruby' }.to_ostruct

        expect(result.name).to eq('Ruby')
      end

      it 'does not mutate the original hash' do
        hash = { language: { name: 'Ruby' } }
        hash.to_ostruct

        expect(hash[:language]).to be_a(Hash)
        expect(hash[:language][:name]).to eq('Ruby')
      end
    end
  end
end
