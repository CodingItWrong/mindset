# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#tags' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:users_first_thought) {
      FactoryBot.create(:thought, user: user, tag_list: 'foo bar')
    }
    let!(:users_second_thought) {
      FactoryBot.create(:thought, user: user, tag_list: 'foo baz')
    }

    let!(:other_user) { FactoryBot.create(:user) }
    let!(:other_user_thought) {
      FactoryBot.create(:thought, user: other_user, tag_list: 'foo qux')
    }

    it 'includes only tags used by this user' do
      expected_ordered_tags = %w[bar baz foo]
      expect(user.tags.map(&:name)).to eq(expected_ordered_tags)
    end
  end
end
