# frozen_string_literal: true

class Answer
  include ActiveModel::Model

  attr_accessor :thought, :text

  validates :thought, :text, presence: true

  def initialize(thought, params = nil)
    self.thought = thought
    self.text = params[:text] if params.present?
  end

  def save
    thought.update(resolution: text) if valid?
  end
end
