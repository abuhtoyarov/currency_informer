require 'rails_helper'

RSpec.describe Currency::FetchRate do
  subject { described_class.call }

  let(:respone_body) do
    {
      'base' => 'USD',
      'date' => '2020-04-24',
      'rates' => {
        'RUB' => 74.4436111111
      }
    }.to_json
  end

  describe '#call' do
    context 'when response successed' do
      before do
        stub_request(:get, 'http://api.exchangeratesapi.io/latest?base=USD&symbols=RUB')
          .to_return(status: 200, body: respone_body,
                     headers: {
                       'Accept' => 'application/json', 'content-type' => 'application/json'
                     })
      end

      it 'return response' do
        expect(subject.rate).to eq 74.4436111111
        expect(subject.time).to eq '2020-04-24'
        expect(subject.success).to be true
      end
    end

    context 'when response failed' do
      before do
        stub_request(:get, 'http://api.exchangeratesapi.io/latest?base=USD&symbols=RUB').to_timeout
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
