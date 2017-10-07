# frozen_string_literal: true

module Tags
  class UnansweredPrayersController < ApplicationController
    def index
      @tag = ActsAsTaggableOn::Tag.find(params[:tag_id])
      @prayers = current_user.unanswered_prayers
                             .joins(:tags)
                             .where('tags.id' => @tag.id)
                             .order(:text)
    end
  end
end