require 'rails_helper'

RSpec.describe Currency::RatePublisher do
  subject { described_class }

  describe '#call' do
    context 'when no rate limit is set' do
      it 'broadcast with real rate' do
        expect { subject.call(rate: 10) }.to have_broadcasted_to('update_rate').with(rate: 10)
      end
    end

    context 'when the rate limit is set' do
      let(:rate) { Rate.create(force_price: 10, force_date_time: 5.minute.since) }

      it 'force rate broadcast' do
        expect { subject.call(rate: 20) }.to have_broadcasted_to('update_rate').with(rate: rate.force_price.to_f)
      end

      context 'when time limit expires' do
        before do
          Timecop.travel(rate.force_date_time.since(1.minute))
        end

        after do
          Timecop.return
        end

        it 'broadcast with real rate' do
          expect { subject.call(rate: 20) }.to have_broadcasted_to('update_rate').with(rate: 20)
        end

        it 'update rate' do
          subject.call(rate: 20)

          expect(rate.reload.price.to_f).to eq 20
        end
      end
    end
  end
end
