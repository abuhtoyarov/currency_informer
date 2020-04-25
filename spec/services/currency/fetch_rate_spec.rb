require 'rails_helper'

RSpec.describe Currency::FetchRate do
  subject { described_class.call }

  describe '#call' do
    context 'when response successed' do
      before do
        stub_fetch_rate(rate: 74.4436111111)
      end

      it 'return response' do
        expect(subject.rate).to eq 74.4436111111
        expect(subject.date).to eq '2020-04-24'
        expect(subject.success).to be true
      end
    end

    context 'when response failed' do
      before do
        stub_timeout_fetch_rate
      end

      describe '#call' do
        it 'return response' do
          expect(subject.success).to be false
          expect(subject.error).to eq 'Error receiving data'
        end
      end
    end
  end
end
