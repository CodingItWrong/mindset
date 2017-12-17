# frozen_string_literal: true

module Thoughts
  class ResolvedController < ApplicationController
    def index
      @prayers = current_user.resolved_thoughts.order(:text)
    end
  end
end
