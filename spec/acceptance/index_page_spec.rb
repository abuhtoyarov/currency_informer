# frozen_string_literal: true

require_relative 'acceptance_helper'

RSpec.feature 'Update rate' do
  scenario 'currency rate displayed', js: true do
    visit root_path
  end
end
