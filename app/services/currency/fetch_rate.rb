module Currency
  class FetchRate < ::ApplicationService
    include HTTParty
    base_uri 'api.exchangeratesapi.io'

    def call
      request
    end

    private

    def request
      response = self.class.get('/latest', query: options)
      build_success_response(response)
    rescue Timeout::Error
      build_error_response('Error receiving data')
    end

    def options
      {
        base: 'USD',
        symbols: 'RUB'
      }
    end

    def build_success_response(response)
      response = response.parsed_response

      rate = response.dig('rates', 'RUB')
      date = response.dig('date')

      OpenStruct.new(rate: rate, date: date, success: true)
    end

    def build_error_response(message)
      OpenStruct.new(error: message, success: false)
    end
  end
end
