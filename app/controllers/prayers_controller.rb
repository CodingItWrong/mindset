class PrayersController < ApplicationController
  def index
    if current_user
      if current_user.prayers.empty?
        redirect_to new_prayer_path
      else
        if next_prayer_id = flash[:next_prayer_id]
          @prayer = current_user.prayers.find(next_prayer_id)
        elsif last_prayer_id = flash[:last_prayer_id]
          if current_user.prayers.where('id <> ?', flash[:last_prayer_id]).count > 0
            @prayer = current_user.prayers.where('id <> ?', flash[:last_prayer_id]).sample
          else
            @prayer = current_user.prayers.sample
          end
        else
          @prayer = current_user.prayers.sample
        end
        flash[:last_prayer_id] = @prayer.id
      end
    end
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
    @prayer = current_user.prayers.find(params[:id])
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

  def prayer_params
    params.require(:prayer).permit(:text)
  end
end
