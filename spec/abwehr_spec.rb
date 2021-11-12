require 'spec_helper'
require 'date'
require './lib/abwehr.rb'

RSpec.describe Abwehr do
  context 'German Military Intellegence' do
    let(:message) {"Hello World"}
    let(:key)     {"02715"}
    let(:date)    {"040895"}

    let(:today)   {Date.today}

    let(:abwehr) {Abwehr.new(message, key, date)}
    let(:abwehr_1) {Abwehr.new(message, key)}
    let(:abwehr_2) {Abwehr.new(message)}

    describe 'Abwehr' do
      it 'exists' do

        expect(abwehr).to be_a(Abwehr)
      end

      it 'has attributes' do

        expect(abwehr.message).to eq("Hello World")
        expect(abwehr.key).to eq("02715")
        expect(abwehr.date).to eq("040895")
      end
    end

    describe 'Abwehr' do

      context 'integration/unit test for dateable/keyable modules' do

        it 'can provide default key and date' do
          #require "pry"; binding.pry

          expect(abwehr_2.message).to eq("Hello World")
          expect(abwehr_2.key.length).to eq(5)
          expect(abwehr_2.key.class).to eq(String)
          expect(abwehr_2.date).to eq(today.strftime("%d%m%Y"))
        end

        it 'can provide a default date' do

          expect(abwehr_1.message).to eq("Hello World")
          expect(abwehr_1.key).to eq("02715")
          expect(abwehr_1.date).to eq(today.strftime("%d%m%Y"))
        end
      end
    end
  end
end
