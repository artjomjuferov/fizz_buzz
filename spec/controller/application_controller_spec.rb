require 'rails_helper'

describe ApplicationController, type: :controller do

  describe '#get_int_param' do
    subject { ApplicationController.new.send :get_int_param, value }

    context 'when value nil' do
      let(:value) { nil }
      it { is_expected.to be_nil }
    end

    context 'when value is positive' do
      let(:value) { 1 }
      it { is_expected.to eq 1 }
    end

    context 'when value is negative' do
      let(:value) { -1 }
      it { is_expected.to be_nil }
    end

    context 'when value is 0' do
      let(:value) { 0 }
      it { is_expected.to be_nil }
    end

    context 'when value is "a"' do
      let(:value) { "a" }
      it { is_expected.to be_nil }
    end
  end

  describe '#get_numbers' do
    subject { ApplicationController.new.send :get_numbers, amount, page }

    context 'when amount is 10 and page is 1' do
      let(:amount){ 10 }
      let(:page){ 1 }

      it 'returns array size of 10' do
        expect(subject.size).to eq 10
      end

      it 'returns array first element is 1' do
        obj = subject.first
        expect(obj[:number]).to eq 1
      end

      it 'returns array last element is 10' do
        obj = subject.last
        expect(obj[:number]).to eq 10
      end
    end

    context 'when amount is 1000 and page is 10' do
      let(:amount){ 1000 }
      let(:page){ 10 }

      it 'returns array size of 1000' do
        expect(subject.size).to eq 1000
      end

      it 'returns array first element is 9001' do
        obj = subject.first
        expect(obj[:number]).to eq 9001
      end

      it 'returns array last element is 10000' do
        obj = subject.last
        expect(obj[:number]).to eq 10000
      end
    end
  end


  describe 'PUT #make_favorite' do
    before(:each) { put 'make_favorite', number: number  }
    after(:each) { Favorite.delete_all }

    context 'when 2 same numbers marked' do
      let(:number) { 2 }
      before(:each) { put 'make_favorite', number: number  }

      it 'is success' do
        expect(response).to have_http_status 200
      end

      it 'creates only one' do
        expect(Favorite.count).to eq 1
      end

      it 'returns true' do
        res = JSON.parse(response.body)
        expect(res).to eq({"was_marked" => true})
      end
    end

    context "when wrong value" do
      [-1, 'z', 10**12].each do |wrong_number|
        context "when number is #{wrong_number}" do
          let(:number) { wrong_number }

          it 'is not success' do
            expect(response).to have_http_status 406
          end

          it 'does not create anything' do
            expect(Favorite.count).to eq 0
          end

          it 'returns false' do
            res = JSON.parse(response.body)
            expect(res).to eq({"was_marked" => false})
          end
        end
      end
    end
  end
end