# frozen_string_literal: true

module Api
  class ThoughtsController < ApiController
    def index
      render json: current_user.thoughts
    end

    def create
      prayer = current_user.thoughts.build(prayer_params)
      if prayer.save
        render json: prayer, status: :created
      else
        render json: prayer.errors, status: :unprocessable_entity
      end
    end

    def update
      prayer = current_user.thoughts.find(params[:id])
      if prayer.update(prayer_params)
        render json: prayer, status: :ok
      else
        render json: prayer.errors, status: :unprocessable_entity
      end
    end

    def destroy
      prayer = current_user.prayers.find(params[:id])
      prayer.destroy!
      head :ok
    end

    private

    def new_prayer_params
      {}.tap do |new_prayer_params|
        if params[:tag].present?
          name = ActsAsTaggableOn::Tag.find(params[:tag]).name
          new_prayer_params[:tag_list] = name
        end
      end
    end

    def prayer_params
      prayer_params = params.require(:prayer)
                            .permit(:text, :resolution)
      if (tags = params[:prayer][:tags])
        prayer_params = prayer_params.merge(tag_list: tags)
      end
      prayer_params
    end
  end
end
