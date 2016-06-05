require 'rails_helper'

describe Number, type: :model do

  subject { Number.new 1 }

  it { is_expected.to respond_to :to_s, :to_hash }

  describe "#name" do
    subject { Number.new(value).send :name }

    context 'when value 15' do
      let(:value) { 15 }
      it { is_expected.to eq 'FizzBuzz'}
    end

    context 'when value 3' do
      let(:value) { 3 }
      it { is_expected.to eq 'Fizz' }
    end

    context 'when value 5' do
      let(:value) { 5 }
      it { is_expected.to eq 'Buzz' }
    end

    context 'when value 1' do
      let(:value) { 1 }
      it { is_expected.to be_nil }
    end
  end

  describe '#to_s' do
    subject { Number.new(5).to_s }

    it { is_expected.to eq 5 }
  end

  describe '#to_hash' do
    before(:each) do
      allow(Favorite).to receive_message_chain(:where, :exists?).and_return true
    end

    subject { Number.new(5).to_hash }

    let(:result) do
      {
          name: 'Buzz',
          number: 5,
          is_favorite: true
      }
    end

    it { is_expected.to eq result }
  end
end