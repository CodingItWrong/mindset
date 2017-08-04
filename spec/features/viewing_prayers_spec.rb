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

    fill_in :prayer_text, with: 'Custom prayer'
    click_on 'Add Prayer'

    expect(page).to have_content('Custom prayer')

    find('.panel:last-child a').click

    expect(page).not_to have_content('Custom prayer')
  end
end
