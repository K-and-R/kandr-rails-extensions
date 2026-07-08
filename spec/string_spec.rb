# frozen_string_literal: true

require 'spec_helper'

describe String do
  context 'using StringTitleize' do
    it 'makes a string title case without exclusions' do
      expect(
        'now I lay me down to sleep'.titleize_with_exclusions
      ).to eq('Now I Lay Me Down To Sleep')
    end

    it 'excludes a word when passed' do
      expect(
        'now I lay me down to sleep'.titleize_with_exclusions(exclude: 'to')
      ).to eq('Now I Lay Me Down to Sleep')
    end

    it 'excludes multiple words when passed' do
      expect(
        'now I lay me down to sleep'.titleize_with_exclusions(exclude: %w[to me])
      ).to eq('Now I Lay me Down to Sleep')
    end

    it 'supports `titleize(exclude:)` on the public method' do
      expect(
        'now I lay me down to sleep'.titleize(exclude: 'to')
      ).to eq('Now I Lay Me Down to Sleep')
    end

    it 'supports legacy hash-style options' do
      expect(
        'now I lay me down to sleep'.titleize(exclude: 'to')
      ).to eq('Now I Lay Me Down to Sleep')
      expect(
        'a to b'.titleize({ exclude: 'to' })
      ).to eq('A to B')
    end

    it 'supports a positional options hash (forced args path)' do
      # Ruby 3 may treat a bare hash as kwargs; splat forces the *args branch
      expect(
        'a to b'.titleize(*[{ exclude: 'to' }])
      ).to eq('A to B')
      expect(
        'a to b'.titleize_with_exclusions(*[{ exclude: 'to' }])
      ).to eq('A to B')
    end

    it 'falls back to ActiveSupport when exclude is blank' do
      expect('hello world'.titleize(exclude: nil)).to eq('Hello World')
      expect('hello world'.titleize(exclude: '')).to eq('Hello World')
      expect('hello world'.titleize(exclude: [])).to eq('Hello World')
    end

    it 'still supports ActiveSupport keep_id_suffix' do
      expect(
        'string_ending_with_id'.titleize(keep_id_suffix: true)
      ).to eq('String Ending With Id')
    end
  end

  context 'using StringToBoolean' do
    truthy_values = %w[true t yes y on 1 fals noo fal 000]
    falsy_values = %w[false f no n off 0]

    context 'when evaluating truthyness' do
      truthy_values.each do |val|
        it %(sees "#{val}" as truthy) do
          expect(val.truthy?).to be_true
        end
      end

      falsy_values.each do |val|
        it %(does not see "#{val}" as truthy) do
          expect(val.truthy?).to be_false
        end
      end

      it 'sees blank strings as not truthy' do
        expect(''.truthy?).to be_false
        expect('   '.truthy?).to be_false
      end
    end

    context 'when evaluating falsyness' do
      falsy_values.each do |val|
        it %(sees "#{val}" as falsy) do
          expect(val.falsy?).to be_true
        end
      end

      truthy_values.each do |val|
        it %(does not see "#{val}" as falsy) do
          expect(val.falsy?).to be_false
        end
      end

      it 'sees blank strings as not falsy' do
        expect(''.falsy?).to be_false
        expect('   '.falsy?).to be_false
      end
    end

    context 'when converting to boolean' do
      falsy_values.each do |val|
        it %(converts "#{val}" to false) do
          expect(val.to_bool).to be_false
        end
      end

      truthy_values.each do |val|
        it %(converts "#{val}" to true) do
          expect(val.to_bool).to be_true
        end
      end

      it 'raises ArgumentError for blank strings' do
        expect { ''.to_bool }.to raise_error(ArgumentError, /invalid value for Boolean/)
        expect { '   '.to_bool }.to raise_error(ArgumentError, /invalid value for Boolean/)
      end
    end
  end

  context 'using StringIncludes' do
    it 'returns true when the substring is found' do
      expect('foobar'.includes?('foo')).to be_true
      expect('foobar'.includes?('bar')).to be_true
    end

    it 'returns false when the substring is not found' do
      expect('foobar'.includes?('baz')).to be_false
    end

    it 'works as a class method (module inclusion check)' do
      expect(String.includes?(Comparable)).to be_true
      expect(String.includes?(Enumerable)).to be_false
    end
  end

  context 'using StringPresent' do
    it 'sees empty and whitespace as blank' do
      expect(''.blank?).to be_true
      expect('   '.blank?).to be_true
    end

    it 'sees non-empty strings as present' do
      expect('hello'.blank?).to be_false
      expect('hello'.present?).to be_true
    end

    it 'sees empty and whitespace as not present' do
      expect(''.present?).to be_false
      expect('   '.present?).to be_false
    end

    it 'implements module blank?/present? (may be shadowed by ActiveSupport)' do
      blank = KandrRailsExtensions::StringPresent.instance_method(:blank?)
      present = KandrRailsExtensions::StringPresent.instance_method(:present?)

      expect(blank.bind_call('')).to be true
      expect(blank.bind_call('hello')).to be false
      expect(present.bind_call('hello')).to be true
      expect(present.bind_call('')).to be false
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

    it 'converts @ to at' do
      expect('me @ home'.slugify).to eq('me_at_home')
    end

    it 'converts & to and' do
      expect('this & that'.slugify).to eq('this_and_that')
    end

    it 'strips apostrophes' do
      expect("it's fine".slugify).to eq('its_fine')
    end

    it 'strips leading and trailing underscores' do
      expect('  hello world  '.slugify).to eq('hello_world')
    end
  end

  context 'using StringTrim' do
    context 'checking `trim`' do
      it 'trims spaces from both sides by default' do
        expect('  hello  '.dup.trim).to eq('hello')
      end

      it 'trims a custom character from both sides' do
        expect('xxxhelloxxx'.dup.trim('x')).to eq('hello')
      end

      it 'limits how many characters are trimmed when count is given' do
        expect('   hello   '.dup.trim(' ', 1)).to eq('  hello  ')
        expect('xxxhelloxxx'.dup.trim('x', 2)).to eq('xhellox')
      end
    end

    context 'checking `ltrim` / `trim_leading`' do
      it 'trims from the left only' do
        expect('  hello  '.dup.ltrim).to eq('hello  ')
        expect('xxxhelloxxx'.dup.trim_leading('x')).to eq('helloxxx')
      end

      it 'limits leading trims when count is given' do
        expect('xxxhello'.dup.ltrim('x', 2)).to eq('xhello')
      end

      it 'returns self when nothing is trimmed' do
        s = 'hello'.dup
        expect(s.ltrim('x')).to be(s)
      end
    end

    context 'checking `rtrim` / `trim_trailing`' do
      it 'trims from the right only' do
        expect('  hello  '.dup.rtrim).to eq('  hello')
        expect('xxxhelloxxx'.dup.trim_trailing('x')).to eq('xxxhello')
      end

      it 'limits trailing trims when count is given' do
        expect('helloxxx'.dup.rtrim('x', 2)).to eq('hellox')
      end

      it 'returns self when nothing is trimmed' do
        s = 'hello'.dup
        expect(s.rtrim('x')).to be(s)
      end
    end
  end
end
