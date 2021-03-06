require 'rails_helper'

RSpec.describe Rate, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:force_price) }

    describe '.force_date_time_cannot_be_in_the_past' do
      let!(:rate) { Rate.new(force_date_time: 5.minute.ago, price: 10) }

      it 'is expected to validate that :force_date_time cannot be past' do
        expect(rate.valid?).to be false
      end
    end

    describe '.current_price' do
      context 'when force_date_time is past' do
        let!(:rate) { Rate.new(force_date_time: 5.minute.ago, price: 10) }

        it { expect(rate.current_price).to eq rate.price }
      end

      context 'when force_date_time is nil' do
        let!(:rate) { Rate.new(force_date_time: nil, price: 10) }

        it { expect(rate.current_price).to eq rate.price }
      end

      context 'when force_date_time is future' do
        let!(:rate) { Rate.new(force_date_time: 5.minute.since, price: 10, force_price: 20) }

        it { expect(rate.current_price).to eq rate.force_price }
      end
    end
  end
end
