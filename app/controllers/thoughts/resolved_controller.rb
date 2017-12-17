# frozen_string_literal: true

module Thoughts
  class ResolvedController < ApplicationController
    def index
      @prayers = current_user.answered_prayers.order(:text)
    end
  end
end
