# frozen_string_literal: true

class PrayersController < ApplicationController
  def index
    @prayers = current_user.prayers.order(:text)
  end

  def show
    if current_user.unanswered_prayers.empty?
      redirect_to new_prayer_path
      return
    end

    @prayer = prayer_to_show
    flash[:last_prayer_id] = @prayer.id
  end

  def new
    @prayer = current_user.prayers.build
  end

  def create
    @prayer = current_user.prayers.build(prayer_params)
    if @prayer.save
      flash[:next_prayer_id] = @prayer.id
      redirect_to root_path, notice: 'Prayer created.'
    else
      render :new
    end
  end

  def edit
    prayer_id = params[:id]
    @prayer = current_user.prayers.find(prayer_id)
    flash[:next_prayer_id] = prayer_id
  end

  def update
    @prayer = current_user.prayers.find(params[:id])
    if @prayer.update(prayer_params)
      flash[:next_prayer_id] = @prayer.id
      redirect_to root_path, notice: 'Prayer updated.'
    else
      render :edit
    end
  end

  def destroy
    @prayer = current_user.prayers.find(params[:id])
    @prayer.destroy!
    redirect_to root_path, notice: 'Prayer deleted.'
  end

  private

  def prayer_to_show
    if (prayer_id = params[:id] || flash[:next_prayer_id])
      current_user.unanswered_prayers.find(prayer_id)
    elsif flash[:last_prayer_id]
      random_prayer
    else
      current_user.unanswered_prayers.sample
    end
  end

  def random_prayer
    if other_prayers.any?
      other_prayers.sample
    else
      current_user.unanswered_prayers.sample
    end
  end

  def other_prayers
    last_id = flash[:last_prayer_id]
    @other_prayers ||= current_user.unanswered_prayers.where('id <> ?', last_id)
  end

  def prayer_params
    params.require(:prayer).permit(:text)
  end
end
