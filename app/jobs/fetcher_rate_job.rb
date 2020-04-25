class FetcherRateJob < ApplicationJob
  queue_as :fetch

  def perform
    loop do
      result = Currency::FetchRate.call

      Currency::RatePublisher.call(rate: result.rate)

      logger.debug "current rate=#{result.rate}"

      sleep 60
    end
  end
end
