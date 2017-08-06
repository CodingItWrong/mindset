class PrayersController < ApplicationController
  def index
    if current_user
      redirect_to new_prayer_path if current_user.prayers.empty?
      @prayer = current_user.prayers.sample
    end
  end

  def new
    @prayer = current_user.prayers.build
  end

  def create
    @prayer = current_user.prayers.build(prayer_params)
    if @prayer.save
      redirect_to root_path, notice: 'Prayer created.'
    else
      render :new
    end
  end

  def edit
    @prayer = current_user.prayers.find(params[:id])
  end

  def update
    @prayer = current_user.prayers.find(params[:id])
    if @prayer.update(prayer_params)
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

  def prayer_params
    params.require(:prayer).permit(:text)
  end
end
