# frozen_string_literal: true

class Thought < ApplicationRecord
  belongs_to :user
  acts_as_taggable

  validates :text, presence: true

  scope :resolved, -> { where.not(resolution: nil) }
  scope :unresolved, -> { where(resolution: nil) }

  def unresolved?
    !resolved?
  end

  def resolved?
    resolution.present?
  end
end
