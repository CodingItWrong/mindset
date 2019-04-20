# frozen_string_literal: true

module Api
  class ThoughtsController < ApiController
    def index
      render json: current_user.thoughts
    end

    def create
      thought = current_user.thoughts.build(thought_params)
      if thought.save
        render json: thought, status: :created
      else
        render json: thought.errors, status: :unprocessable_entity
      end
    end

    def update
      thought = current_user.thoughts.find(params[:id])
      if thought.update(thought_params)
        render json: thought, status: :ok
      else
        render json: thought.errors, status: :unprocessable_entity
      end
    end

    def destroy
      thought = current_user.thoughts.find(params[:id])
      thought.destroy!
      head :ok
    end

    private

    def new_thought_params
      {}.tap do |new_thought_params|
        if params[:tag].present?
          name = ActsAsTaggableOn::Tag.find(params[:tag]).name
          new_thought_params[:tag_list] = name
        end
      end
    end

    def thought_params
      thought_params = params.require(:thought).permit(:text, :resolution)
      if (tags = params[:thought][:tags])
        thought_params = thought_params.merge(tag_list: tags)
      end
      thought_params
    end
  end
end
