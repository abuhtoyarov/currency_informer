class FetcherRateJob < ApplicationJob
  RUN_EVERY = 1.minute

  queue_as :fetch

  def perform
    result = Currency::FetchRate.call

    Currency::RatePublisher.call(rate: result.rate)

    logger.debug "current rate=#{result.rate}"

    self.class.set(wait: RUN_EVERY).perform_later
  end
end
