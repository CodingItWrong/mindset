# frozen_string_literal: true

class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @prayers = Prayer.joins(:tags).where('tags.id' => @tag.id)
  end
end
