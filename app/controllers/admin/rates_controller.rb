# frozen_string_literal: true

module Admin
  class RatesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      @rate = current_rate
    end

    def update
      rate = current_rate

      if rate.update(rate_params)
        Currency::RatePublisher.call(rate: rate.price)

        head :ok
      else
        render json: { errors: rate.errors.full_messages }, status: 422
      end
    end

    private

    def rate_params
      params.require(:rate).permit(:force_price, :force_date_time)
    end
  end
end
