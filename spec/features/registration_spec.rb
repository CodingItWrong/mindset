require 'rails_helper'

RSpec.feature 'registration', type: :feature do
  it 'allows users to create an account' do
    visit '/'
    click_on 'Sign up'

    password = 'password'
    fill_in 'Email', with: 'example@example.com'
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_on 'Sign up'

    expect(page).to have_content(/signed up successfully/)

    click_on 'Log out'

    click_on 'Log in'
    fill_in 'Email', with: 'example@example.com'
    fill_in 'Password', with: password
    click_on 'Log in'

    click_on 'Log out'
  end
end
