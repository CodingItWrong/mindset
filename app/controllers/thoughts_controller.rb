# frozen_string_literal: true

class ThoughtsController < ApplicationController
  def show
    if (prayer_id = params[:id])
      @thought = current_user.thoughts.find(prayer_id)
    else
      if current_user.unresolved_thoughts.empty?
        redirect_to new_thought_path
        return
      end
      @thought = random_prayer
    end
    flash[:last_prayer_id] = @thought.id
  end

  def new
    @thought = current_user.thoughts.build(new_prayer_params)
  end

  def create
    @thought = current_user.thoughts.build(prayer_params)
    if @thought.save
      redirect_to @thought, notice: 'Thought created.'
    else
      render :new
    end
  end

  def edit
    prayer_id = params[:id]
    @thought = current_user.thoughts.find(prayer_id)
  end

  def update
    @thought = current_user.thoughts.find(params[:id])
    if @thought.update(prayer_params)
      redirect_to @thought, notice: 'Thought updated.'
    else
      render :edit
    end
  end

  def destroy
    @thought = current_user.thoughts.find(params[:id])
    @thought.destroy!
    redirect_to root_path, notice: 'Thought deleted.'
  end

  private

  def random_prayer
    if other_prayers.any?
      other_prayers.sample
    else
      current_user.unresolved_thoughts.sample
    end
  end

  def other_prayers
    last_id = flash[:last_prayer_id]
    @other_prayers ||= current_user.unresolved_thoughts.where('id <> ?', last_id)
  end

  def new_prayer_params
    {}.tap do |new_prayer_params|
      if params[:tag].present?
        name = ActsAsTaggableOn::Tag.find(params[:tag]).name
        new_prayer_params[:tag_list] = name
      end
    end
  end

  def prayer_params
    params.require(:thought).permit(:text, :tag_list)
  end
end
