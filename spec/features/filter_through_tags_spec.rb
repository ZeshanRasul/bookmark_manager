require 'spec_helper'

feature 'Filtering through tags' do
  scenario 'Filtering through the bubbles tag' do
    visit '/links/new'
    fill_in 'bookmark_name', with: 'Bubble Stuff'
    fill_in 'url', with: 'www.bubblesaregreat.com'
    fill_in 'tag', with: 'bubbles'
    click_button 'create link'

    visit '/links/new'
    fill_in 'bookmark_name', with: 'No Bubble Stuff'
    fill_in 'url', with: 'www.nobubbles.com'
    fill_in 'tag', with: 'no'
    click_button 'create link'

    visit '/links/tags/bubbles'
    expect(page).to have_content('Bubble Stuff')
    expect(page).not_to have_content('No Bubble Stuff')
  end

end
