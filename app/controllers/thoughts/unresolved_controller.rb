# frozen_string_literal: true

module Thoughts
  class UnresolvedController < ApplicationController
    def index
      @thoughts = current_user.unresolved_thoughts.order(:text)
    end
  end
end
