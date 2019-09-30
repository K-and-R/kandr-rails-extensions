# frozen_string_literal: true

require 'spec_helper'

describe String do
  context 'using StringTitleize' do
    it 'makes a string title case without exclusions' do
      expect(
        'now I lay me down to sleep'.titleize_with_exclusions
      ).to eq('Now I Lay Me Down To Sleep')
    end
  end

  context 'using StringToBoolean' do
    truthy_values = %w[true t yes y on 1 fals noo fal 000]
    falsy_values = %w[false f no n off 0]

    context 'when evaluating truthyness' do
      truthy_values.each do |val|
        it %Q[sees "#{val}" as truthy] do
          expect(val.truthy?).to be_true
        end
      end

      falsy_values.each do |val|
        it %Q[does not see "#{val}" as truthy] do
          expect(val.truthy?).to be_false
        end
      end
    end

    context 'when evaluating falsyness' do
      falsy_values.each do |val|
        it %Q[sees "#{val}" as falsy] do
          expect(val.falsy?).to be_true
        end
      end

      truthy_values.each do |val|
        it %Q[does not see "#{val}" as falsy] do
          expect(val.falsy?).to be_false
        end
      end
    end

    context 'when converting to boolean' do
      falsy_values.each do |val|
        it %Q[converys "#{val}" to false] do
          expect(val.to_bool).to be_false
        end
      end

      truthy_values.each do |val|
        it %Q[converys "#{val}" to true] do
          expect(val.to_bool).to be_true
        end
      end
    end
  end

  context 'using StringSlugify' do
    it 'makes a slug from a string with just letters and spaces' do
      expect(
        'now I lay me down to sleep'.slugify
      ).to eq('now_i_lay_me_down_to_sleep')
    end

    it 'removes consecutive spaces' do
      expect(
        'now I   lay me     down to sleep'.slugify
      ).to eq('now_i_lay_me_down_to_sleep')
    end

    it 'removes dashes' do
      expect(
        'now I - - lay me - -down to-sleep'.slugify
      ).to eq('now_i_lay_me_down_to_sleep')
    end

    it 'removes punctuation characters' do
      expect(
        'now, I LAY me down ...to sleep!'.slugify
      ).to eq('now_i_lay_me_down_to_sleep')
    end
  end
end
