# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :doorkeeper_authorize!

    def current_user
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token.present?
    end
  end
end
