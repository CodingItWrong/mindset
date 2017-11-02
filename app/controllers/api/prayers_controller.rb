# frozen_string_literal: true

module Api
  class PrayersController < ApiController
    def index
      render json: current_user.prayers
    end
  end
end
