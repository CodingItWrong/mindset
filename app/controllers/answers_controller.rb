# frozen_string_literal: true

class AnswersController < ApplicationController
  def new
    @prayer = current_user.prayers.find(params[:prayer_id])
    @answer = Answer.new(@prayer)
  end

  def create
    prayer = current_user.prayers.find(params[:prayer_id])
    @answer = Answer.new(prayer, answer_params)
    if @answer.save
      redirect_to root_path, notice: 'Prayer answer recorded.'
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:text)
  end
end
