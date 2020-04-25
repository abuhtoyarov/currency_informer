# frozen_string_literal: true

class IndexController < ApplicationController
  def index
    @rate = current_rate
  end
end
