class PrayersController < ApplicationController
  def index
    @prayers = Prayer.all
  end
end
