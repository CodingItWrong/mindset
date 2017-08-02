require 'rails_helper'

RSpec.feature 'viewing prayers', type: :feature do
  it 'displays all prayers for the user' do
    user = FactoryGirl.create(:user)
    sign_in user

    prayers = FactoryGirl.create_list(:prayer, 3, user: user)

    visit '/'
    prayers.each do |prayer|
      expect(page).to have_content(prayer.text)
    end
  end
end
