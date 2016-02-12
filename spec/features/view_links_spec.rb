# As a time-pressed user
# So that I can quickly go to web sites I regularly visit
# I would like to see a list of links on the homepage

require 'spec_helper'

feature 'View Link' do

  scenario 'go to homepage and see a list of link' do
    Link.create(url: 'http://www.bookmark.com', bookmark_name: 'Favorite link')

    visit '/links'
    expect(page.status_code).to eq 200

     within 'ul#link' do
      expect(page).to have_content('Favorite link')
     end
  end

end
