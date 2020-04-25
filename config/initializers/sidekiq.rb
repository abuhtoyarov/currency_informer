Sidekiq.configure_server do |config|
  config.on(:startup) do
    FetcherRateJob.perform_later
  end
end
