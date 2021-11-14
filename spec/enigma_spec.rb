require 'spec_helper'
require 'date'
require './lib/enigma.rb'
require './lib/encryptable'


RSpec.describe Enigma do
  let(:message) {"Hello World"}
  let(:key)     {"02715"}
  let(:date)    {"040895"}
  let(:offset)  {"1025"}

  let(:today)   {Date.today}

  let(:enigma) {Enigma.new}

  describe 'Enigma' do
    it 'exists' do

      expect(enigma).to be_a(Enigma)
    end

    it 'has attributes' do

      expect(enigma.message).to eq('')
      expect(enigma.key).to eq('')
      expect(enigma.date).to eq('')
    end

    it 'can create a list of valid characters' do
      expected = ('a'..'z').to_a.push(' ')
      expect(enigma.valid_chars).to eq(expected)
    end
  end

  describe 'Enigma Class Methods' do
    it '#key_maker can create a random key' do

      expect(enigma.key_maker.length).to eq(5)
      expect(enigma.key_maker).to be_a(String)
    end

    it '#time_lord can create a date' do

      expect(enigma.time_lord.length).to eq(8)
      expect(enigma.time_lord).to be_a(String)
    end

    it 'can calculate an #offset_value' do

      expect(enigma.offset_value(date)).to eq("1025")
    end

    it 'can generate #the_shift for the message' do

      expect(enigma.the_shift(offset, key)).to eq([3, 27, 73, 20])
    end
  end

  describe '#Cypher' do
    context 'accepts a message and returns it encrypted' do
      let(:long_test) {"this is longer"}
      let(:char_test) {"h2ll% .or{_"}
      let(:all_invalid) {"12{$56&*}_"}
      let(:space_cadet) {"   "}
      let(:shift) {[3, 27, 73, 20]}

      it 'counts spaces as valid characters' do

        expect(enigma.cypher(space_cadet, shift)).to eq("c s")
      end

      it 'can return an encrypted message' do

        expect(enigma.cypher(message, shift)).to eq("keder ohulw")
      end

      it 'returns strings of equal length as the string given' do

        expect(enigma.cypher(message, shift).length).to eq(11)
        expect(enigma.cypher(long_test, shift).length).to eq(14)
      end

      it 'skips invalid characters' do

        expect(enigma.cypher(char_test, shift)).to eq("k2ld%t.rr{_")
        expect(enigma.cypher(all_invalid, shift)).to eq("12{$56&*}_")
      end
    end
  end

  describe '#Encrypt' do
    context 'integration test for dateable/keyable modules' do

      it 'can take/set message, key, and date arguments' do
        enigma.encrypt(message, key, date)

        expect(enigma.message).to eq("Hello World")
        expect(enigma.key).to eq("02715")
        expect(enigma.date).to eq("040895")
      end

      it 'can provide default key' do
        enigma.encrypt(message)

        expect(enigma.key.length).to eq(5)
        expect(enigma.key.class).to eq(String)
      end

      it 'can provide a default date' do
        enigma.encrypt(message, key)

        expect(enigma.date).to eq(today.strftime("%d%m%Y"))
      end
    end
  end
end
