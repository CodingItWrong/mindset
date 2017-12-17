# frozen_string_literal: true

module Thoughts
  class UnresolvedController < ApplicationController
    def index
      @prayers = current_user.unanswered_prayers.order(:text)
    end
  end
end
