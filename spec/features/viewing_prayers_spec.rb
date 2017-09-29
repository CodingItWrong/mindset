# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'viewing prayers', type: :feature do
  it 'displays all prayers for the user' do
    user = FactoryGirl.create(:user)
    sign_in user

    prayer1 = 'Custom prayer'
    prayer2 = 'Another prayer'
    tags = %w[foo bar]
    tag = tags.first
    updated_prayer2 = 'Enhanced prayer'
    answer = 'It happened!'

    creating_first_prayer_displays_that_prayer(prayer1, tags)
    next_when_only_one_prayer_redisplays(prayer1)
    creating_additional_prayer_displays_that_prayer(prayer2)
    list_displays([prayer1, prayer2])
    tag_list_displays(tag, prayer1)
    creating_prayer_from_tag_list_prepopulates_tag(tag)
    editing_prayer_redisplays_same_prayer(prayer2, updated_prayer2)
    editing_prayer_and_cancelling_redisplays_same_prayer(updated_prayer2)
    next_displays(prayer1)
    deleting_prayer_displays(updated_prayer2)
    answering_prayer_hides_it(updated_prayer2, answer)
    answered_prayer_not_shown_in_unanswered_list(updated_prayer2)
    answered_prayer_shown_in_answered_list(updated_prayer2, answer)
  end

  private

  def creating_first_prayer_displays_that_prayer(prayer, tags)
    visit '/'

    fill_in :prayer_text, with: prayer
    fill_in :prayer_tag_list, with: tags.join(' ')
    click_on 'Save Prayer'

    expect(page).to have_content('Prayer created')
    expect(page).to have_content(prayer)
    tags.each do |tag|
      expect(page).to have_content(tag)
    end
  end

  def next_when_only_one_prayer_redisplays(prayer)
    click_on 'Next'
    expect(page).to have_content(prayer)
  end

  def creating_additional_prayer_displays_that_prayer(prayer)
    click_on_first_link 'Add Prayer'

    fill_in :prayer_text, with: prayer
    click_on 'Save Prayer'

    expect(page).to have_content(prayer)
  end

  def list_displays(prayers)
    click_on 'Unanswered'
    aggregate_failures do
      prayers.each { |prayer| expect(page).to have_content(prayer) }
    end
  end

  def tag_list_displays(tag, prayer)
    click_on 'Tags'
    click_on tag
    expect(page).to have_content(prayer)
    click_on(prayer)
    click_on tag
    expect(page).to have_content(prayer)
  end

  def creating_prayer_from_tag_list_prepopulates_tag(tag)
    click_on 'Tags'
    click_on tag
    click_on_first_link 'Add Prayer'

    expect(page).to have_field(:prayer_tag_list, with: tag)
  end

  def editing_prayer_redisplays_same_prayer(prayer, updated_prayer)
    click_on 'Unanswered'
    click_on prayer
    click_on_first_link 'Edit'
    fill_in :prayer_text, with: updated_prayer
    click_on 'Save Prayer'

    expect(page).to have_content('Prayer updated')
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

    expect(page).to have_content('Prayer deleted')
    expect(page).to have_content(prayer)
  end

  def answering_prayer_hides_it(prayer, answer)
    expect(page).to have_content(prayer)

    click_on_first_link 'Answer'
    expect(page).to have_content(prayer)

    click_on 'Mark Answered'
    expect(page).to have_content("can't be blank")

    fill_in :answer_text, with: answer
    click_on 'Mark Answered'

    expect(page).to have_content('Prayer answer recorded')
    expect(page).not_to have_content(prayer)
  end

  def answered_prayer_not_shown_in_unanswered_list(prayer)
    click_on 'Unanswered'
    expect(page).not_to have_content(prayer)
  end

  def answered_prayer_shown_in_answered_list(prayer, answer)
    click_on 'Answered'
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
