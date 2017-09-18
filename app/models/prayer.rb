# frozen_string_literal: true

class Prayer < ApplicationRecord
  belongs_to :user

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
