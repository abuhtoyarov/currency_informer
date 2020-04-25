# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Indices', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      stub_fetch_rate(rate: 74.4436111111)

      get '/index/index'
      expect(response).to have_http_status(:success)
    end
  end
end
