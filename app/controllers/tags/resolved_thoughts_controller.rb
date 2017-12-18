# frozen_string_literal: true

module Tags
  class ResolvedThoughtsController < ApplicationController
    def index
      @tag = ActsAsTaggableOn::Tag.find(params[:tag_id])
      @thoughts = current_user.resolved_thoughts
                             .joins(:tags)
                             .where('tags.id' => @tag.id)
                             .order(:text)
    end
  end
end
