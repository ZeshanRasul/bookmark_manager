feature 'sign out' do
  before do
    create_user
    sign_in
  end

  scenario 'a user signs out and views a goodbye message' do
    click_button 'Sign out'
    expect(page).to have_content 'Goodbye'
  end

end
