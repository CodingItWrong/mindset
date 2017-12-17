# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'viewing prayers', type: :feature do
  it 'displays all prayers for the user' do
    user = FactoryBot.create(:user)
    sign_in user

    prayer1 = 'Custom prayer'
    prayer2 = 'Another prayer'
    updated_prayer2 = 'Enhanced prayer'
    answer = 'It happened!'

    creating_first_prayer_displays_that_prayer(prayer1)
    next_when_only_one_prayer_redisplays(prayer1)
    creating_additional_prayer_displays_that_prayer(prayer2)
    list_displays([prayer1, prayer2])
    editing_prayer_redisplays_same_prayer(prayer2, updated_prayer2)
    editing_prayer_and_cancelling_redisplays_same_prayer(updated_prayer2)
    next_displays(prayer1)
    deleting_prayer_displays(updated_prayer2)
    answering_prayer_hides_it(updated_prayer2, answer)
    answered_prayer_not_shown_in_unanswered_list(updated_prayer2)
    answered_prayer_shown_in_answered_list(updated_prayer2, answer)
  end

  private

  def creating_first_prayer_displays_that_prayer(prayer)
    visit '/'

    fill_in :prayer_text, with: prayer
    click_on 'Save Thought'

    expect(page).to have_content('Thought created')
    expect(page).to have_content(prayer)
  end

  def next_when_only_one_prayer_redisplays(prayer)
    click_on 'Next'
    expect(page).to have_content(prayer)
  end

  def creating_additional_prayer_displays_that_prayer(prayer)
    click_on_first_link 'Add Thought'

    fill_in :prayer_text, with: prayer
    click_on 'Save Thought'

    expect(page).to have_content(prayer)
  end

  def list_displays(prayers)
    click_on 'Thoughts'
    click_on 'Unresolved'
    aggregate_failures do
      prayers.each { |prayer| expect(page).to have_content(prayer) }
    end
  end

  def editing_prayer_redisplays_same_prayer(prayer, updated_prayer)
    click_on 'Thoughts'
    click_on 'Unresolved'
    click_on prayer
    click_on_first_link 'Edit'
    fill_in :prayer_text, with: updated_prayer
    click_on 'Save Thought'

    expect(page).to have_content('Thought updated')
    expect(page).to have_content(updated_prayer)
  end

  def editing_prayer_and_cancelling_redisplays_same_prayer(prayer)
    click_on_first_link 'Edit'
    click_on 'Cancel'

    expect(page).to have_content(prayer)
  end

  def next_displays(prayer)
    click_on 'Next'
    expect(page).to have_content(prayer)
  end

  def deleting_prayer_displays(prayer)
    click_on_first_link 'Delete'

    expect(page).to have_content('Thought deleted')
    expect(page).to have_content(prayer)
  end

  def answering_prayer_hides_it(prayer, answer)
    expect(page).to have_content(prayer)

    click_on_first_link 'Resolve'
    expect(page).to have_content(prayer)

    click_on 'Mark Resolved'
    expect(page).to have_content("can't be blank")

    fill_in :answer_text, with: answer
    click_on 'Mark Resolved'

    expect(page).to have_content('Thought resolution recorded')
    expect(page).not_to have_content(prayer)
  end

  def answered_prayer_not_shown_in_unanswered_list(prayer)
    click_on 'Thoughts'
    click_on 'Unresolved'
    expect(page).not_to have_content(prayer)
  end

  def answered_prayer_shown_in_answered_list(prayer, answer)
    click_on 'Resolved'
    expect(page).to have_content(prayer)

    click_on prayer
    expect(page).to have_content(prayer)
    expect(page).to have_content(answer)
  end

  private

  def click_on_first_link(text)
    page.first(:link, text: /^#{Regexp.quote(text)}$/).click
  end
end
