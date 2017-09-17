# frozen_string_literal: true

class AnsweredController < ApplicationController
  def index
    @prayers = current_user.answered_prayers.order(:text)
  end
end
