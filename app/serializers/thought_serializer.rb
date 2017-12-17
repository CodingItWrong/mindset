# frozen_string_literal: true

class ThoughtSerializer < ActiveModel::Serializer
  attributes %i[id text answer]

  has_many :tags do
    object.tags.map(&:name)
  end
end
