require 'spec_helper'
require 'date'
require './lib/enigma.rb'
require './lib/encryptable'


RSpec.describe Enigma do
  let(:enigma)  {Enigma.new}

  let(:today)   {Date.today}

  let(:message) {"Hello World"}
  let(:key)     {"02715"}
  let(:date)    {"040895"}

  let(:offset)  {"1025"}


  describe 'Enigma' do
    it 'exists' do

      expect(enigma).to be_a(Enigma)
    end

    it 'has attributes' do

      expect(enigma.message).to eq('')
      expect(enigma.key).to eq('')
      expect(enigma.date).to eq('')
      expect(enigma.encrypted_data).to eq(nil)
      expect(enigma.decrypted_data).to eq(nil)
    end
  end

  describe 'Encryptable module' do
    include Encryptable
    context 'unit testing for Encryptable module' do
      it 'can provide an array of valid characters' do
        expected = ('a'..'z').to_a.push(' ')

        expect(valid_chars).to eq(expected)
      end

      it 'can calculate an #offset_value' do

        expect(offset_value(date)).to eq("1025")
      end

      it 'can generate #the_shift for the message' do

        expect(the_shift(offset, key)).to eq([3, 27, 73, 20])
      end
    end

    describe '#Cypher' do
      context 'unit testing for #cypher' do
        let(:shift)   {[3, 27, 73, 20]}
        let(:long_test)   {"this is longer"}
        let(:char_test)   {"h2ll% .or{_"}
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

    describe '#decypher' do
      context 'unit tests for #decypher' do
        let(:shift_2)   {[3, 27, 73, 20]}
        let(:message_crypted)     {"keder ohulw"}
        let(:char_test_crypted)   {"k2ld%t.rr{_"}
        let(:all_invalid)         {"12{$56&*}_"}
        let(:space_cadet_crypted) {"c s"}

        it 'counts spaces as valid characters' do

          expect(decypher(space_cadet_crypted, shift_2)).to eq("   ")
        end

        it 'can return an encrypted message' do

          expect(decypher(message_crypted, shift_2)).to eq("hello world")
        end

        it 'returns strings of equal length as the string given' do

          expect(decypher(message_crypted, shift_2).length).to eq(11)
        end

        it 'skips invalid characters' do

          expect(decypher(char_test_crypted, shift_2)).to eq("h2ll% .or{_")
          expect(decypher(all_invalid, shift_2)).to eq("12{$56&*}_")
        end
      end
    end
  end

  describe 'Enigma class method #encrypt' do
    context 'integration test for dateable/keable/encryptable modules' do

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

        expect(enigma.date).to eq(today.strftime("%d%m%y"))
        expect(enigma.date.length).to eq(6)
      end

      it 'returns a hash containing the encrypted text, the key, and the date used' do
        expected = {
          encryption: "keder ohulw",
          key: "02715",
          date: "040895"
        }

        expect(enigma.encrypt(message, key, date)).to eq(expected)
      end
    end
  end

  describe 'Enigma class method #decrypt' do
    context 'integration test for dateable/keable/encryptable modules' do
      let(:message_crypted)     {"keder ohulw"}
      it 'can take/set message, key, and date arguments' do
        enigma.decrypt(message_crypted, key, date)

        expect(enigma.message).to eq("keder ohulw")
        expect(enigma.key).to eq("02715")
        expect(enigma.date).to eq("040895")
      end

      it 'can provide the key used in encryption if not given' do
        enigma.encrypt(message, key)
        enigma.decrypt(message_crypted)

        expect(enigma.key).to eq("02715")
      end

      it 'can provide the date used in encryption if not given' do
        enigma.encrypt(message, key, date)
        enigma.decrypt(message_crypted, key)

        expect(enigma.date).to eq("040895")
      end

      it 'returns a hash containing the encrypted text, the key, and the date used' do
        expected = {
          decryption: "hello world",
          key: "02715",
          date: "040895"
        }

        expect(enigma.decrypt(message_crypted, key, date)).to eq(expected)
      end
    end
  end
end
