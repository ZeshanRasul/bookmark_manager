require 'spec_helper'
require './app/app.rb'

feature 'Adding links' do

  scenario 'Adding a link' do

    visit '/links/new'
    fill_in 'url', with: 'www.wordpress.com'
    fill_in 'title', with: 'Wordpress'
    click_button('Add')

    expect(current_path).to eq '/links'

    within 'ul#links' do
      expect(page).to have_text('www.wordpress.com')
    end

  end
  DatabaseCleaner.clean


end
