# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'viewing thoughts', type: :feature do
  it 'displays all thoughts for the user' do
    user = FactoryBot.create(:user)
    sign_in user

    thought1 = 'Custom thought'
    thought2 = 'Another thought'
    updated_thought2 = 'Enhanced thought'
    answer = 'It happened!'

    creating_first_thought_displays_that_thought(thought1)
    next_when_only_one_thought_redisplays(thought1)
    creating_additional_thought_displays_that_thought(thought2)
    list_displays([thought1, thought2])
    editing_thought_redisplays_same_thought(thought2, updated_thought2)
    editing_thought_and_cancelling_redisplays_same_thought(updated_thought2)
    next_displays(thought1)
    deleting_thought_displays(updated_thought2)
    answering_thought_hides_it(updated_thought2, answer)
    answered_thought_not_shown_in_unanswered_list(updated_thought2)
    answered_thought_shown_in_answered_list(updated_thought2, answer)
  end

  private

  def creating_first_thought_displays_that_thought(thought)
    visit '/'

    fill_in :thought_text, with: thought
    click_on 'Save Thought'

    expect(page).to have_content('Thought created')
    expect(page).to have_content(thought)
  end

  def next_when_only_one_thought_redisplays(thought)
    click_on 'Next'
    expect(page).to have_content(thought)
  end

  def creating_additional_thought_displays_that_thought(thought)
    click_on_first_link 'Add Thought'

    fill_in :thought_text, with: thought
    click_on 'Save Thought'

    expect(page).to have_content(thought)
  end

  def list_displays(thoughts)
    click_on 'Thoughts'
    click_on 'Unresolved'
    aggregate_failures do
      thoughts.each { |thought| expect(page).to have_content(thought) }
    end
  end

  def editing_thought_redisplays_same_thought(thought, updated_thought)
    click_on 'Thoughts'
    click_on 'Unresolved'
    click_on thought
    click_on_first_link 'Edit'
    fill_in :thought_text, with: updated_thought
    click_on 'Save Thought'

    expect(page).to have_content('Thought updated')
    expect(page).to have_content(updated_thought)
  end

  def editing_thought_and_cancelling_redisplays_same_thought(thought)
    click_on_first_link 'Edit'
    click_on 'Cancel'

    expect(page).to have_content(thought)
  end

  def next_displays(thought)
    click_on 'Next'
    expect(page).to have_content(thought)
  end

  def deleting_thought_displays(thought)
    click_on_first_link 'Delete'

    expect(page).to have_content('Thought deleted')
    expect(page).to have_content(thought)
  end

  def answering_thought_hides_it(thought, answer)
    expect(page).to have_content(thought)

    click_on_first_link 'Resolve'
    expect(page).to have_content(thought)

    click_on 'Mark Resolved'
    expect(page).to have_content("can't be blank")

    fill_in :resolution_text, with: answer
    click_on 'Mark Resolved'

    expect(page).to have_content('Thought resolution recorded')
    expect(page).not_to have_content(thought)
  end

  def answered_thought_not_shown_in_unanswered_list(thought)
    click_on 'Thoughts'
    click_on 'Unresolved'
    expect(page).not_to have_content(thought)
  end

  def answered_thought_shown_in_answered_list(thought, answer)
    click_on 'Resolved'
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
