# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#tags' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:users_first_prayer) {
      FactoryGirl.create(:prayer, user: user, tag_list: 'foo bar')
    }
    let!(:users_second_prayer) {
      FactoryGirl.create(:prayer, user: user, tag_list: 'foo baz')
    }

    let!(:other_user) { FactoryGirl.create(:user) }
    let!(:other_user_prayer) {
      FactoryGirl.create(:prayer, user: other_user, tag_list: 'foo qux')
    }

    it 'includes only tags used by this user' do
      expected_ordered_tags = %w[bar baz foo]
      expect(user.tags.map(&:name)).to eq(expected_ordered_tags)
    end
  end
end
