class PrayersController < ApplicationController
  def index
    if current_user
      @prayers = current_user.prayers
      @new_prayer = current_user.prayers.build
    end
  end

  def create
    @new_prayer = current_user.prayers.create(prayer_params)
    if @new_prayer.save
      redirect_to root_path
    else
      @prayers = current_user.prayers
      render :index
    end
  end

  private

  def prayer_params
    params.require(:prayer).permit(:text)
  end
end
