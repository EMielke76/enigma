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

      expect(enigma.message).to eq("")
      expect(enigma.key).to eq("")
      expect(enigma.date).to eq("")
    end

    it 'can create a list of valid characters' do
      expected = ('a'..'z').to_a.push(' ')
      expect(enigma.char_array).to eq(expected)
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

  describe '#Encrypt' do
    context 'integration/unit test for dateable/keyable modules' do
      xit 'can provide default key and date' do


        #require "pry"; binding.pry

        expect(enigma.encrypt(message, key, date)).to eq("Hello World")
        expect(abwehr_2.key.length).to eq(5)
        expect(abwehr_2.key.class).to eq(String)
        expect(abwehr_2.date).to eq(today.strftime("%d%m%Y"))
      end

      xit 'can provide a default date' do

        expect(abwehr_1.message).to eq("Hello World")
        expect(abwehr_1.key).to eq("02715")
        expect(abwehr_1.date).to eq(today.strftime("%d%m%Y"))
      end
    end
  end
end
