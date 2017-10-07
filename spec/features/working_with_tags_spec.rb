# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'working with tags', type: :feature do
  it 'displays all prayers for the user' do
    user = FactoryGirl.create(:user)
    sign_in user

    prayer1 = 'Custom prayer'
    prayer2 = 'Another prayer'
    tags = %w[foo bar]
    tag = tags.first

    creating_prayer_with_tags_displays_those_tags(prayer1, tags)
    creating_additional_prayer_displays_that_prayer(prayer2)
    tag_list_displays(tag, prayer1)
    creating_prayer_from_tag_list_prepopulates_tag(tag)
  end

  private

  def creating_prayer_with_tags_displays_those_tags(prayer, tags)
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

  def creating_additional_prayer_displays_that_prayer(prayer)
    click_on_first_link 'Add Prayer'

    fill_in :prayer_text, with: prayer
    click_on 'Save Prayer'

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
    click_on_first_link 'Add Prayer'

    expect(page).to have_field(:prayer_tag_list, with: tag)
  end

  private

  def click_on_first_link(text)
    page.first(:link, text: /^#{Regexp.quote(text)}$/).click
  end
end
