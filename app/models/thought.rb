# frozen_string_literal: true

class Thought < ApplicationRecord
  belongs_to :user
  acts_as_taggable

  validates :text, presence: true

  scope :answered, -> { where.not(answer: nil) }
  scope :unanswered, -> { where(answer: nil) }

  def unanswered?
    !answered?
  end

  def answered?
    answer.present?
  end
end
