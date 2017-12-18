# frozen_string_literal: true

module Thoughts
  class ResolvedController < ApplicationController
    def index
      @thoughts = current_user.resolved_thoughts.order(:text)
    end
  end
end
