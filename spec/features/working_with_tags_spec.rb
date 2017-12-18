# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'working with tags', type: :feature do
  it 'displays all prayers for the user' do
    user = FactoryBot.create(:user)
    sign_in user

    prayer1 = 'Custom prayer'
    prayer2 = 'Another prayer'
    tags = %w[foo bar]
    tag = tags.first
    answer = 'It happened!'

    creating_prayer_with_tags_displays_those_tags(prayer1, tags)
    creating_additional_prayer_displays_that_prayer(prayer2)
    tag_list_displays(tag, prayer1)
    creating_prayer_from_tag_list_prepopulates_tag(tag)
    answering_prayer_hides_it_from_tag_list(tag, prayer1, answer)
    answered_prayer_shown_in_answered_list(tag, prayer1, answer)
  end

  private

  def creating_prayer_with_tags_displays_those_tags(prayer, tags)
    visit '/'

    fill_in :thought_text, with: prayer
    fill_in :thought_tag_list, with: tags.join(' ')
    click_on 'Save Thought'

    expect(page).to have_content('Thought created')
    expect(page).to have_content(prayer)
    tags.each do |tag|
      expect(page).to have_content(tag)
    end
  end

  def creating_additional_prayer_displays_that_prayer(prayer)
    click_on_first_link 'Add Thought'

    fill_in :thought_text, with: prayer
    click_on 'Save Thought'

    expect(page).to have_content(prayer)
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
    click_on_first_link 'Add Thought'

    expect(page).to have_field(:thought_tag_list, with: tag)
  end

  def answering_prayer_hides_it_from_tag_list(tag, prayer, answer)
    click_on 'Tags'
    click_on tag
    expect(page).to have_content(prayer)

    click_on prayer
    click_on_first_link 'Resolve'
    expect(page).to have_content(prayer)

    click_on 'Mark Resolved'
    expect(page).to have_content("can't be blank")

    fill_in :resolution_text, with: answer
    click_on 'Mark Resolved'

    expect(page).to have_content('Thought resolution recorded')
    expect(page).not_to have_content(prayer)

    click_on 'Tags'
    click_on tag
    expect(page).not_to have_content(prayer)
  end

  def answered_prayer_shown_in_answered_list(tag, prayer, answer)
    click_on 'Resolved'
    expect(page).to have_content(tag)
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
