# frozen_string_literal: true

class ThoughtsController < ApplicationController
  def show
    if (thought_id = params[:id])
      @thought = current_user.thoughts.find(thought_id)
    else
      if current_user.unresolved_thoughts.empty?
        redirect_to new_thought_path
        return
      end
      @thought = random_thought
    end
    flash[:last_thought_id] = @thought.id
  end

  def new
    @thought = current_user.thoughts.build(new_thought_params)
  end

  def create
    @thought = current_user.thoughts.build(thought_params)
    if @thought.save
      redirect_to @thought, notice: 'Thought created.'
    else
      render :new
    end
  end

  def edit
    thought_id = params[:id]
    @thought = current_user.thoughts.find(thought_id)
  end

  def update
    @thought = current_user.thoughts.find(params[:id])
    if @thought.update(thought_params)
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

  def random_thought
    if other_thoughts.any?
      other_thoughts.sample
    else
      current_user.unresolved_thoughts.sample
    end
  end

  def other_thoughts
    last_id = flash[:last_thought_id]
    @other_thoughts ||= current_user.unresolved_thoughts.where('id <> ?', last_id)
  end

  def new_thought_params
    {}.tap do |new_thought_params|
      if params[:tag].present?
        name = ActsAsTaggableOn::Tag.find(params[:tag]).name
        new_thought_params[:tag_list] = name
      end
    end
  end

  def thought_params
    params.require(:thought).permit(:text, :tag_list)
  end
end
