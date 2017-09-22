# frozen_string_literal: true

class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all.order(:name)
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @prayers = current_user.prayers
                           .joins(:tags)
                           .where('tags.id' => @tag.id)
                           .order(:text)
  end
end
