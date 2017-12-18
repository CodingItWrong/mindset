# frozen_string_literal: true

class ResolutionsController < ApplicationController
  def new
    @prayer = current_user.thoughts.find(params[:thought_id])
    @answer = Resolution.new(@prayer)
  end

  def create
    @prayer = current_user.thoughts.find(params[:thought_id])
    @answer = Resolution.new(@prayer, answer_params)
    if @answer.save
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
