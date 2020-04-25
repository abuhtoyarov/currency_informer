# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def current_rate
    Rate.first_or_create
  end
end
