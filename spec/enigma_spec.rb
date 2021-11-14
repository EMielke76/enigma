require 'spec_helper'
require 'date'
require './lib/enigma.rb'
require './lib/encryptable'


RSpec.describe Enigma do
  let(:enigma) {Enigma.new}

  let(:today)   {Date.today}

  let(:message) {"Hello World"}
  let(:key)     {"02715"}
  let(:date)    {"040895"}

  let(:offset)  {"1025"}
  let(:shift) {[3, 27, 73, 20]}

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
  end

  describe 'Encryptable' do
    include Encryptable
    context 'unit testing for Encryptable module' do
      it 'can calculate an #offset_value' do

        expect(offset_value(date)).to eq("1025")
      end

      it 'can generate #the_shift for the message' do

        expect(the_shift(offset, key)).to eq([3, 27, 73, 20])
      end
    end

    context '#Cypher' do
      let(:long_test) {"this is longer"}
      let(:char_test) {"h2ll% .or{_"}
      let(:all_invalid) {"12{$56&*}_"}
      let(:space_cadet) {"   "}
      
      it 'counts spaces as valid characters' do

        expect(cypher(space_cadet, shift)).to eq("c s")
      end

      it 'can return an encrypted message' do

        expect(cypher(message, shift)).to eq("keder ohulw")
      end

      it 'returns strings of equal length as the string given' do

        expect(cypher(message, shift).length).to eq(11)
        expect(cypher(long_test, shift).length).to eq(14)
      end

      it 'skips invalid characters' do

        expect(cypher(char_test, shift)).to eq("k2ld%t.rr{_")
        expect(cypher(all_invalid, shift)).to eq("12{$56&*}_")
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
