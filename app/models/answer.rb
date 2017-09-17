# frozen_string_literal: true

class Answer
  include ActiveModel::Model

  attr_accessor :prayer, :text

  validates :prayer, :text, presence: true

  def initialize(prayer, params = nil)
    self.prayer = prayer
    self.text = params[:text] if params.present?
  end

  def save
    @prayer.update(answer: text) if valid?
  end
end
