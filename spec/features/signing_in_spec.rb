
feature 'signing in' do

  before do
    create_user
  end

  scenario 'existing user goes to sign-in page from homepage and signs in' do
    expect{ sign_in }.not_to change(User, :count)
    expect(page).to have_content('Welcome Bob')
  end

end
