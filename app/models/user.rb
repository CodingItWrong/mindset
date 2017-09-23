# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :prayers

  def answered_prayers
    Prayer.answered { prayers }
  end

  def unanswered_prayers
    Prayer.unanswered { prayers }
  end

  def tags
    tags_for_user = <<-QUERY
      SELECT t1.*
      FROM tags AS t1
      INNER JOIN taggings t2
        ON t1.id = t2.tag_id
      INNER JOIN prayers p
        ON t2.taggable_type = 'Prayer' AND t2.taggable_id = p.id
      WHERE p.user_id = ?
      ORDER BY t1.name
    QUERY
    ActsAsTaggableOn::Tag.find_by_sql([tags_for_user, id])
  end
end
