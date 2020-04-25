class FetcherRateJob < ApplicationJob
  queue_as :fetch

  def perform
    loop do
      result = Currency::FetchRate.call

      ActionCable.server.broadcast('update_rate', {
                                     rate: result.rate,
                                     date: result.date
                                   })

      logger.debug "current rate=#{result.rate}"

      sleep 60
    end
  end
end
