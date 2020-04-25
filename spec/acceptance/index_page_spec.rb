# frozen_string_literal: true

require_relative 'acceptance_helper'

RSpec.feature 'Rate is displayed on the main page', '
  In order to watch the rate
  As an guest
  I want to be able to watch the rate change
' do
  background do
    stub_fetch_rate(rate: 74.4436111111)
  end

  scenario 'rate displayed', js: true do
    visit root_path

    expect(page).to have_content '74.443611111'
  end
end
