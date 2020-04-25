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

      current_rate.update(price: new_rate) if Time.current > current_rate.force_date_time

      @new_rate = current_rate.price
    end

    def broadcast_to
      ActionCable.server.broadcast('update_rate', { rate: new_rate })
    end
  end
end
