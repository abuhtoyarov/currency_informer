# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin#Rates', type: :request do
  describe 'PUT /admin/rates' do
    context 'when all correct' do
      it 'returns http success' do
        put '/admin/rates', params: { rate: { force_date_time: 5.minute.since, force_price: 10 } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'when force date time is past' do
      it 'returns http 422' do
        put '/admin/rates', params: { rate: { force_date_time: Time.current, force_price: 10 } }

        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET /admin' do
    it 'returns http success' do
      get '/admin'
      expect(response).to have_http_status(:success)
    end
  end
end
