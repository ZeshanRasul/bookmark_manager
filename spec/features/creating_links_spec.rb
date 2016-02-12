require 'spec_helper'

feature 'creating links' do
  scenario 'user adds links and they are stored' do
    visit'/links/new'
    # click_button'add link'
    fill_in 'bookmark_name', with: 'bookmark name'
    fill_in 'url', with: 'www.url.co.uk'
    fill_in 'tag', with: 'I am a fish.'
    click_button'create link'
    expect(current_path).to eq '/links'
    within 'ul#link' do
      expect(page).to have_content('bookmark name')
    end
  end
end
