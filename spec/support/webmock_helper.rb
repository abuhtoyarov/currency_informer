module WebmockHelper
  WebMock.disable_net_connect!(allow_localhost: true)

  def stub_fetch_rate(rate:)
    respone_body = {
      'base' => 'USD',
      'date' => '2020-04-24',
      'rates' => {
        'RUB' => rate
      }
    }.to_json
    stub_request(:get, 'http://api.exchangeratesapi.io/latest?base=USD&symbols=RUB')
      .to_return(status: 200, body: respone_body,
                 headers: {
                   'Accept' => 'application/json', 'content-type' => 'application/json'
                 })
  end

  def stub_timeout_fetch_rate
    stub_request(:get, 'http://api.exchangeratesapi.io/latest?base=USD&symbols=RUB').to_timeout
  end
end
