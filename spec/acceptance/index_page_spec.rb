# frozen_string_literal: true

require_relative 'acceptance_helper'

RSpec.feature 'Rate is displayed on the main page', '
  In order to watch the rate
  As an guest
  I want to be able to watch the rate change
' do

  scenario 'rate displayed', js: true do
    visit root_path
    
    sleep 1
    
    Currency::RatePublisher.call(rate: 74.4436111111)
    
    expect(page).to have_content '74.443611111'
  end
end
