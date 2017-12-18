# frozen_string_literal: true

class ResolutionsController < ApplicationController
  def new
    @thought = current_user.thoughts.find(params[:thought_id])
    @resolution = Resolution.new(@thought)
  end

  def create
    @thought = current_user.thoughts.find(params[:thought_id])
    @resolution = Resolution.new(@thought, answer_params)
    if @resolution.save
      redirect_to root_path, notice: 'Thought resolution recorded.'
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:resolution).permit(:text)
  end
end
