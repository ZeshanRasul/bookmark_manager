include SessionHelpers

feature 'Sign Up' do
  scenario 'A user visits the sign-up page and signs up' do
    sign_up
    expect(page).to have_content('Welcome Bob')
    users = User.all
    expect(users.count).to eq(1)
    user = User.first
    expect(user.email).to eq 'bob@gmail.com'
  end

  scenario 'A user submits a different confirmation password' do
      visit '/user/new'
      fill_in('name', with: 'Gill')
      fill_in('email', with: 'gill@obo.com')
      fill_in('password', with: '0987')
      fill_in('password_confirmation', with: 't70889')
      click_button('Submit')
      user = User.first
      expect(user).to eq nil
      expect(page).to have_content("Password does not match the confirmation")
    end

  scenario 'A user does not submit an email address' do
    visit '/user/new'
    fill_in('name', with: 'Gill')
    fill_in('email', with: nil)
    fill_in('password', with: '0987')
    fill_in('password_confirmation', with: '0987')
    expect { click_button('Submit') }.not_to change(User, :count)
    expect(page).to have_content("Email must not be blank")
  end

  scenario 'A user submits an incorrectly formatted email' do
    visit '/user/new'
    fill_in('name', with: 'Geb')
    fill_in('email', with: 'hasdfjal')
    fill_in('password', with: '0987')
    fill_in('password_confirmation', with: '0987')
    expect { click_button('Submit') }.not_to change(User, :count)
  end

  scenario 'A user signs up with already registered email' do
    User.create(name: 'Bob', email: 'bob@gmail.com', password: 'password', password_confirmation: 'password')
    visit '/user/new'
    fill_in('name', with: 'Hannah')
    fill_in('email', with: 'bob@gmail.com')
    fill_in('password', with: '0987')
    fill_in('password_confirmation', with: '0987')
    expect { click_button('Submit') }.not_to change(User, :count)
    expect(page).to have_content("Email is already taken")
  end

end
