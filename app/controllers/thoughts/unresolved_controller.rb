# frozen_string_literal: true

module Thoughts
  class UnresolvedController < ApplicationController
    def index
      @prayers = current_user.unresolved_thoughts.order(:text)
    end
  end
end
