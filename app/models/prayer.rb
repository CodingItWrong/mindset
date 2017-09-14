# frozen_string_literal: true

class Prayer < ApplicationRecord
  belongs_to :user

  validates :text, presence: true
end
