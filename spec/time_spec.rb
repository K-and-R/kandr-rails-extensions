# frozen_string_literal: true

require 'spec_helper'

describe Time do
  let(:epoch) { Time.at(1_000_000_000) } # 2001-09-09 01:46:40 UTC
  let(:with_ms) { Time.at(1_000_000_000, 123_000) } # +0.123s

  context 'using TimeEpochTime' do
    it 'returns the Unix timestamp via `to_epoch`' do
      expect(epoch.to_epoch).to eq(1_000_000_000)
    end

    it 'aliases `to_posix` to `to_epoch`' do
      expect(epoch.to_posix).to eq(epoch.to_epoch)
    end

    it 'aliases `to_unix` to `to_epoch`' do
      expect(epoch.to_unix).to eq(epoch.to_epoch)
    end

    it 'matches `to_i`' do
      expect(epoch.to_epoch).to eq(epoch.to_i)
    end
  end

  context 'using TimeMilliseconds' do
    it 'returns milliseconds since epoch via `to_ms`' do
      expect(epoch.to_ms).to eq(1_000_000_000_000)
    end

    it 'includes fractional seconds in milliseconds' do
      expect(with_ms.to_ms).to eq(1_000_000_000_123)
    end

    it 'returns an Integer' do
      expect(epoch.to_ms).to be_a(Integer)
    end
  end
end
