# frozen_string_literal: true

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
    list_displays([prayer1, prayer2], then_select: prayer2)
    editing_prayer_redisplays_same_prayer(updated_prayer2)
    editing_prayer_and_cancelling_redisplays_same_prayer(updated_prayer2)
    next_displays(prayer1)
    deleting_prayer_displays(updated_prayer2)
    answering_prayer_hides_it(updated_prayer2)
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

  def list_displays(prayers, then_select:)
    click_on 'All Prayers'
    aggregate_failures do
      prayers.each { |prayer| expect(page).to have_content(prayer) }
    end
    click_on then_select
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

  def answering_prayer_hides_it(prayer)
    expect(page).to have_content(prayer)

    click_on 'Answer'
    fill_in :answer_text, with: 'It happened!'
    click_on 'Mark Answered'

    expect(page).to have_content('Prayer answer recorded')
    expect(page).not_to have_content(prayer)
  end
end
