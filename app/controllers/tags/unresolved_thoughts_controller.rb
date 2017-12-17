# frozen_string_literal: true

module Tags
  class UnresolvedThoughtsController < ApplicationController
    def index
      @tag = ActsAsTaggableOn::Tag.find(params[:tag_id])
      @prayers = current_user.unresolved_thoughts
                             .joins(:tags)
                             .where('tags.id' => @tag.id)
                             .order(:text)
    end
  end
end
