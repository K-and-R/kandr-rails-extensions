# frozen_string_literal: true

require 'spec_helper'

describe Array do
  context 'using ArrayAverage' do
    context 'using integers' do
      it 'gives the average' do
        expect([5, 5, 5, 5, 5].average).to eq(5)
        expect([1, 2, 3, 4, 5].average).to eq(3)
        expect([2, 3, 5, 7, 11, 13, 17, 19, 23, 29].average).to eq(12.9)
      end
    end

    context 'using floats' do
      it 'gives the average' do
        expect([5.5, 5.5, 5.5, 5.5, 5.5].average).to eq(5.5)
        expect([1.5, 2.5, 3.5, 4.5, 5.5].average).to eq(3.5)
        expect(
          [2.0, 3.1, 5.1, 7.2, 11.3, 13.5, 17.8, 19.13, 23.21, 29.34].average
        ).to eq(13.168000000000001) # Should be 13.168, but Ruby gonna Ruby. "¯\_(ツ)_/¯ "
      end
    end

    context 'using strings' do
      it 'raises a TypeError' do
        expect { %w[foo bar baz].average }.to raise_error(TypeError)
        expect { [1.5, 'foo', 5.5].average }.to raise_error(TypeError)
      end
    end

    context 'by default' do
      it 'gives a float response' do
        expect([1, 2, 3, 4, 5].average).to be_a Float
        expect([2, 3, 5, 7, 11, 13, 17, 19, 23, 29].average).to be_a Float
      end
    end

    context 'asking for a `float_average`' do
      it 'gives a float response' do
        expect([1, 2, 3, 4, 5].float_average).to be_a Float
        expect([2, 3, 5, 7, 11, 13, 17, 19, 23, 29].float_average).to be_a Float
      end

      it 'computes the expected value' do
        expect([1, 2, 3, 4, 5].float_average).to eq(3.0)
      end
    end

    context 'asking for an integer response' do
      it 'gives an integer response' do
        expect([2, 3, 5, 7, 11, 13, 17, 19, 23, 29].average(false)).to be_a Integer
      end

      it 'rounds down the integer response' do
        expect([2, 3, 5, 7, 11, 13, 17, 19, 23, 29].average(false)).to eq(12)
      end

      it 'computes via `integer_average`' do
        expect([1, 2, 3, 4, 5].integer_average).to eq(3)
      end
    end

    context 'when empty' do
      it 'returns nil for average' do
        expect([].average).to be_nil
      end

      it 'returns nil for float_average' do
        expect([].float_average).to be_nil
      end

      it 'returns nil for integer_average' do
        expect([].integer_average).to be_nil
      end
    end
  end

  context 'using ArrayIncludes' do
    context 'checking with `includes?`' do
      it 'returns true when element is found' do
        expect([1, 2, 3, 4, 5].includes?(5)).to be_true
        expect(%w[foo bar baz].includes?('bar')).to be_true
      end

      it 'returns false when element is not found' do
        expect([1, 2, 3, 4, 5].includes?(7)).to be_false
        expect(%w[foo boo baz].includes?('bar')).to be_false
      end

      it 'works as a class method (module inclusion check)' do
        expect(Array.includes?(Enumerable)).to be_true
        expect(Array.includes?(Comparable)).to be_false
      end
    end
  end
end
