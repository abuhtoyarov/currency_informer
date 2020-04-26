module Currency
  class RatePublisher < ::ApplicationService
    attr_reader :new_rate

    def initialize(rate:)
      @new_rate = rate
    end

    def call
      take_or_update_current_rate
      broadcast_to
    end

    private

    def take_or_update_current_rate
      current_rate = Rate.first

      return if current_rate.blank? || current_rate.force_date_time.blank?

      if Time.current > current_rate.force_date_time
        current_rate.update_columns(price: new_rate)
      else
        @new_rate = current_rate.force_price.to_f
      end
    end

    def broadcast_to
      ActionCable.server.broadcast('update_rate', { rate: new_rate })
    end
  end
end
