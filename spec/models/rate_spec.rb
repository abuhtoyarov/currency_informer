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
  end
end
