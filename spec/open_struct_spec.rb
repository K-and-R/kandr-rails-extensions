# frozen_string_literal: true

require 'spec_helper'
require 'json'

describe OpenStruct do
  context 'using OpenStructExtensions' do
    context 'checking `to_json`' do
      it 'serializes a flat OpenStruct' do
        result = OpenStruct.new(name: 'Ruby', creator: 'Matz').to_json
        parsed = JSON.parse(result)

        expect(parsed).to eq('name' => 'Ruby', 'creator' => 'Matz')
      end

      it 'recursively serializes nested OpenStructs' do
        result = OpenStruct.new(
          language: OpenStruct.new(name: 'Ruby')
        ).to_json
        parsed = JSON.parse(result)

        expect(parsed).to eq('language' => { 'name' => 'Ruby' })
      end

      it 'recursively serializes OpenStructs inside arrays' do
        result = OpenStruct.new(
          languages: [
            OpenStruct.new(name: 'Ruby'),
            OpenStruct.new(name: 'Python')
          ]
        ).to_json
        parsed = JSON.parse(result)

        expect(parsed['languages']).to eq(
          [{ 'name' => 'Ruby' }, { 'name' => 'Python' }]
        )
      end

      it 'leaves non-struct values alone' do
        result = OpenStruct.new(tags: %w[a b], count: 2).to_json
        parsed = JSON.parse(result)

        expect(parsed).to eq('tags' => %w[a b], 'count' => 2)
      end
    end

    context 'checking `delete`' do
      it 'removes an existing field' do
        os = OpenStruct.new(foo: 'bar', baz: 'qux')
        os.delete(:foo)

        expect(os.to_h).to eq(baz: 'qux')
        expect(os.respond_to?(:foo)).to be false
      end

      it 'does nothing for a missing field' do
        os = OpenStruct.new(foo: 'bar')
        os.delete(:missing)

        expect(os.to_h).to eq(foo: 'bar')
      end
    end

    context 'checking `key?` / `has_key?`' do
      it 'returns true when the field exists' do
        os = OpenStruct.new(foo: 'bar')

        expect(os.key?(:foo)).to be true
        expect(os.has_key?(:foo)).to be true
      end

      it 'returns false when the field does not exist' do
        os = OpenStruct.new(foo: 'bar')

        expect(os.key?(:missing)).to be false
        expect(os.has_key?(:missing)).to be false
      end
    end
  end
end
