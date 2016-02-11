require 'spec_helper'

feature 'tagging a link' do
  before (:each) do
    visit '/link/add-new'
    fill_in 'bookmark_name', with: 'Favourite title'
    fill_in 'url', with: 'www.weeee!.co.uk'

  end

  scenario 'The user adds a tag to a bookmark.' do
    #  visit '/link/add-new'
    # fill_in 'bookmark_name', with: 'Favourite title'
    # fill_in 'url', with: 'www.weeee!.co.uk'
    # fill_in 'tag', with: 'Orcs!'
    # click_button 'create link'
    fill_in 'tag', with: 'Orcs!'
    click_button 'create link'
    link = Link.first
    expect(link.tags.map(&:tag)).to include('Orcs!')
  end

  scenario 'The user adds multiple tags to a bookmark' do
    fill_in 'tag', with: 'Favourite, Shopping, Animals'
    click_button 'create link'
    expect(page).to have_content('Favourite Shopping Animals')
  end
end
