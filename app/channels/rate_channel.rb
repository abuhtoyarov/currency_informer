class RateChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'update_rate'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
