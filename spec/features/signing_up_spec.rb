feature 'Sign Up' do
  scenario 'A user visits the sign-up page and signs up' do
    visit('/user/new')
    fill_in('name', with: 'Bob')
    fill_in('email', with: 'bob@obo.com')
    fill_in('password', with: '123456')
    click_button('Submit')
    expect(page).to have_content('Welcome Bob')
    users = User.all
    expect(users.count).to eq(1)
    user = User.first
    expect(user.email).to eq 'bob@obo.com'
  end
end
