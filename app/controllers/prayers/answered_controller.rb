# frozen_string_literal: true

module Prayers
  class AnsweredController < ApplicationController
    def index
      @prayers = current_user.answered_prayers.order(:text)
    end
  end
end
