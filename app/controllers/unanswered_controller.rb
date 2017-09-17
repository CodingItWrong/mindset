# frozen_string_literal: true

class UnansweredController < ApplicationController
  def index
    @prayers = current_user.unanswered_prayers.order(:text)
  end
end
