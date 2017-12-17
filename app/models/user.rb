# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :thoughts

  def resolved_thoughts
    Thought.resolved { thoughts }
  end

  def unresolved_thoughts
    Thought.unresolved { thoughts }
  end

  TAGS_FOR_USER_QUERY = <<-QUERY
    SELECT DISTINCT t1.*
    FROM tags AS t1
    INNER JOIN taggings t2
      ON t1.id = t2.tag_id
    INNER JOIN thoughts th
      ON t2.taggable_type = 'Thought' AND t2.taggable_id = th.id
    WHERE th.user_id = ?
    ORDER BY t1.name
  QUERY

  def tags
    ActsAsTaggableOn::Tag.find_by_sql([TAGS_FOR_USER_QUERY, id])
  end
end
