require 'rails_helper'

RSpec.feature 'viewing prayers', type: :feature do
  it 'displays all prayers for the user' do
    user = FactoryGirl.create(:user)
    sign_in user

    prayer1 = 'Custom prayer'
    prayer2 = 'Another prayer'
    updated_prayer2 = 'Enhanced prayer'

    creating_first_prayer_displays_that_prayer(prayer1)
    next_when_only_one_prayer_redisplays(prayer1)
    creating_additional_prayer_displays_that_prayer(prayer2)
    editing_prayer_redisplays_same_prayer(updated_prayer2)
    editing_prayer_and_cancelling_redisplays_same_prayer(updated_prayer2)
    next_displays(prayer1)
    deleting_prayer_displays(updated_prayer2)
  end

  private

  def creating_first_prayer_displays_that_prayer(prayer)
    visit '/'

    fill_in :prayer_text, with: prayer
    click_on 'Save Prayer'

    expect(page).to have_content('Prayer created')
    expect(page).to have_content(prayer)
  end

  def next_when_only_one_prayer_redisplays(prayer)
    click_on 'Next'
    expect(page).to have_content(prayer)
  end

  def creating_additional_prayer_displays_that_prayer(prayer)
    click_on 'Add Prayer'

    fill_in :prayer_text, with: prayer
    click_on 'Save Prayer'

    expect(page).to have_content(prayer)
  end

  def editing_prayer_redisplays_same_prayer(prayer)
    click_on 'Edit'
    fill_in :prayer_text, with: prayer
    click_on 'Save Prayer'

    expect(page).to have_content('Prayer updated')
    expect(page).to have_content(prayer)
  end

  def editing_prayer_and_cancelling_redisplays_same_prayer(prayer)
    click_on 'Edit'
    click_on 'Cancel'

    expect(page).to have_content(prayer)
  end

  def next_displays(prayer)
    click_on 'Next'
    expect(page).to have_content(prayer)
  end

  def deleting_prayer_displays(prayer)
    click_on 'Delete'

    expect(page).to have_content('Prayer deleted')
    expect(page).to have_content(prayer)
  end
end
