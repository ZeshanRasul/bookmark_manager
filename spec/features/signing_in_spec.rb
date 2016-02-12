
feature 'signing in' do
  before do
    User.create(name: 'Bob', email: 'bob@gmail.com', password: 'password', password_confirmation: 'password')
  end

  scenario 'existing user goes to sign-in page from homepage and signs in' do
    visit '/user/sign-in'
    fill_in 'email', with: 'bob@gmail.com'
    fill_in 'password', with: 'password'
    expect{click_button'Sign in'}.not_to change(User, :count)
    expect(page).to have_content('Welcome Bob')
  end

end
