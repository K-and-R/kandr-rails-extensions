# frozen_string_literal: true

require 'spec_helper'

describe Integer do
  context 'using IntegerBoolean' do
    context 'checking `to_bool`' do
      it 'is true when not zero' do
        expect(1.to_bool).to be true
        expect(-1.to_bool).to be true
        expect(42.to_bool).to be true
      end

      it 'is false when zero' do
        expect(0.to_bool).to be false
      end
    end
  end

  context 'using IntegerFactorial' do
    context 'checking `factorial`' do
      it 'returns 1 for 0' do
        expect(0.factorial).to eq(1)
      end

      it 'returns 1 for 1' do
        expect(1.factorial).to eq(1)
      end

      it 'computes small factorials' do
        expect(2.factorial).to eq(2)
        expect(3.factorial).to eq(6)
        expect(4.factorial).to eq(24)
        expect(5.factorial).to eq(120)
      end

      it 'aliases as `to_!`' do
        expect(5.to_!).to eq(5.factorial)
        expect(5.to_!).to eq(120)
      end
    end
  end

  context 'using IntegerTermial' do
    context 'checking `termial`' do
      it 'returns 0 for 0' do
        expect(0.termial).to eq(0)
      end

      it 'returns 1 for 1' do
        expect(1.termial).to eq(1)
      end

      it 'computes small termials (triangular numbers)' do
        expect(2.termial).to eq(3)
        expect(3.termial).to eq(6)
        expect(4.termial).to eq(10)
        expect(5.termial).to eq(15)
      end

      it 'aliases as `to_?`' do
        expect(5.to_?).to eq(5.termial)
        expect(5.to_?).to eq(15)
      end
    end
  end
end
