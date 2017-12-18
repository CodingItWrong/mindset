# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'working with tags', type: :feature do
  it 'displays all thoughts for the user' do
    user = FactoryBot.create(:user)
    sign_in user

    thought1 = 'Custom thought'
    thought2 = 'Another thought'
    tags = %w[foo bar]
    tag = tags.first
    answer = 'It happened!'

    creating_thought_with_tags_displays_those_tags(thought1, tags)
    creating_additional_thought_displays_that_thought(thought2)
    tag_list_displays(tag, thought1)
    creating_thought_from_tag_list_prepopulates_tag(tag)
    answering_thought_hides_it_from_tag_list(tag, thought1, answer)
    answered_thought_shown_in_answered_list(tag, thought1, answer)
  end

  private

  def creating_thought_with_tags_displays_those_tags(thought, tags)
    visit '/'

    fill_in :thought_text, with: thought
    fill_in :thought_tag_list, with: tags.join(' ')
    click_on 'Save Thought'

    expect(page).to have_content('Thought created')
    expect(page).to have_content(thought)
    tags.each do |tag|
      expect(page).to have_content(tag)
    end
  end

  def creating_additional_thought_displays_that_thought(thought)
    click_on_first_link 'Add Thought'

    fill_in :thought_text, with: thought
    click_on 'Save Thought'

    expect(page).to have_content(thought)
  end

  def tag_list_displays(tag, thought)
    click_on 'Tags'
    click_on tag
    expect(page).to have_content(thought)
    click_on(thought)
    click_on tag
    expect(page).to have_content(thought)
  end

  def creating_thought_from_tag_list_prepopulates_tag(tag)
    click_on 'Tags'
    click_on tag
    click_on_first_link 'Add Thought'

    expect(page).to have_field(:thought_tag_list, with: tag)
  end

  def answering_thought_hides_it_from_tag_list(tag, thought, answer)
    click_on 'Tags'
    click_on tag
    expect(page).to have_content(thought)

    click_on thought
    click_on_first_link 'Resolve'
    expect(page).to have_content(thought)

    click_on 'Mark Resolved'
    expect(page).to have_content("can't be blank")

    fill_in :resolution_text, with: answer
    click_on 'Mark Resolved'

    expect(page).to have_content('Thought resolution recorded')
    expect(page).not_to have_content(thought)

    click_on 'Tags'
    click_on tag
    expect(page).not_to have_content(thought)
  end

  def answered_thought_shown_in_answered_list(tag, thought, answer)
    click_on 'Resolved'
    expect(page).to have_content(tag)
    expect(page).to have_content(thought)

    click_on thought
    expect(page).to have_content(thought)
    expect(page).to have_content(answer)
  end

  private

  def click_on_first_link(text)
    page.first(:link, text: /^#{Regexp.quote(text)}$/).click
  end
end
