# frozen_string_literal: true

class Thought < ApplicationRecord
  belongs_to :user
  acts_as_taggable

  validates :text, presence: true

  scope :resolved, -> { where.not(answer: nil) }
  scope :unresolved, -> { where(answer: nil) }

  def unanswered?
    !answered?
  end

  def answered?
    answer.present?
  end
end
