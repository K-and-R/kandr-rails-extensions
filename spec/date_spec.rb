# frozen_string_literal: true

require 'spec_helper'

describe Date do
  let(:today) { Date.new(2026, 7, 8) }
  let(:yesterday) { Date.new(2026, 7, 7) }
  let(:tomorrow) { Date.new(2026, 7, 9) }
  let(:next_week) { Date.new(2026, 7, 15) }

  context 'using DateCompare' do
    context 'checking `before?`' do
      it 'matches for a previous date' do
        expect(today.before?(tomorrow)).to be true
      end

      it 'does not match for a future date' do
        expect(today.before?(yesterday)).to be false
      end

      it 'does not match for the same date (exclusive)' do
        expect(today.before?(today)).to be false
      end

      it 'matches the same date when inclusive' do
        expect(today.before?(today, true)).to be true
      end
    end

    context 'checking `after?`' do
      it 'matches for a previous date' do
        expect(today.after?(yesterday)).to be true
      end

      it 'does not match for a future date' do
        expect(today.after?(tomorrow)).to be false
      end

      it 'does not match for the same date (exclusive)' do
        expect(today.after?(today)).to be false
      end

      it 'matches the same date when inclusive' do
        expect(today.after?(today, true)).to be true
      end
    end

    context 'checking `on_or_before?`' do
      it 'matches the same date' do
        expect(today.on_or_before?(today)).to be true
      end

      it 'matches a future date' do
        expect(today.on_or_before?(tomorrow)).to be true
      end

      it 'does not match a past date' do
        expect(today.on_or_before?(yesterday)).to be false
      end
    end

    context 'checking `on_or_after?`' do
      it 'matches the same date' do
        expect(today.on_or_after?(today)).to be true
      end

      it 'matches a past date' do
        expect(today.on_or_after?(yesterday)).to be true
      end

      it 'does not match a future date' do
        expect(today.on_or_after?(tomorrow)).to be false
      end
    end

    context 'checking `between?`' do
      it 'is exclusive on both ends by default (`()`)' do
        expect(today.between?(yesterday, tomorrow)).to be true
        expect(yesterday.between?(yesterday, tomorrow)).to be false
        expect(tomorrow.between?(yesterday, tomorrow)).to be false
      end

      it 'is inclusive on both ends with `[]`' do
        expect(yesterday.between?(yesterday, tomorrow, '[]')).to be true
        expect(tomorrow.between?(yesterday, tomorrow, '[]')).to be true
        expect(today.between?(yesterday, tomorrow, '[]')).to be true
        expect(next_week.between?(yesterday, tomorrow, '[]')).to be false
      end

      it 'is exclusive start, inclusive end with `(]`' do
        expect(yesterday.between?(yesterday, tomorrow, '(]')).to be false
        expect(tomorrow.between?(yesterday, tomorrow, '(]')).to be true
        expect(today.between?(yesterday, tomorrow, '(]')).to be true
      end

      it 'is inclusive start, exclusive end with `[)`' do
        expect(yesterday.between?(yesterday, tomorrow, '[)')).to be true
        expect(tomorrow.between?(yesterday, tomorrow, '[)')).to be false
        expect(today.between?(yesterday, tomorrow, '[)')).to be true
      end

      it 'falls back to exclusive when given an unknown mode' do
        expect(today.between?(yesterday, tomorrow, 'xx')).to be true
        expect(yesterday.between?(yesterday, tomorrow, 'xx')).to be false
        expect(tomorrow.between?(yesterday, tomorrow, 'xx')).to be false
      end
    end
  end
end
