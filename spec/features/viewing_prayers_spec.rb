require 'rails_helper'

RSpec.feature 'viewing prayers', type: :feature do
  it 'displays all prayers for the user' do
    user = FactoryGirl.create(:user)
    sign_in user

    visit '/'
    fill_in :prayer_text, with: 'Custom prayer'
    click_on 'Save Prayer'

    expect(page).to have_content('Prayer created')
    expect(page).to have_content('Custom prayer')

    click_on 'Add Prayer'

    fill_in :prayer_text, with: 'Another prayer'
    click_on 'Save Prayer'

    click_on 'Delete'

    expect(page).to have_content('Prayer deleted')

    click_on "Edit"
    fill_in :prayer_text, with: 'Enhanced prayer'
    click_on 'Save Prayer'

    expect(page).to have_content('Prayer updated')
    expect(page).to have_content('Enhanced prayer')

    click_on 'Delete'

    expect(page).not_to have_content('Custom prayer')
    expect(page).not_to have_content('Another prayer')
  end
end
