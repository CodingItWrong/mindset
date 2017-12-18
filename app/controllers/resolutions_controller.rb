# frozen_string_literal: true

class ResolutionsController < ApplicationController
  def new
    @thought = current_user.thoughts.find(params[:thought_id])
    @answer = Resolution.new(@thought)
  end

  def create
    @thought = current_user.thoughts.find(params[:thought_id])
    @answer = Resolution.new(@thought, answer_params)
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
