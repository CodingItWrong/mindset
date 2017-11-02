# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    before_action :doorkeeper_authorize!

    def current_user
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token.present?
    end
  end
end
