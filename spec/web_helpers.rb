module SessionHelpers

  def create_user
    User.create(name: 'Bob', email: 'bob@gmail.com', password: 'password', password_confirmation: 'password')
  end

  def sign_in
    visit '/sessions/new'
    fill_in 'email', with: 'bob@gmail.com'
    fill_in 'password', with: 'password'
    click_button'Sign in'
  end

  def sign_up
    visit('/users/new')
    fill_in('name', with: 'Bob')
    fill_in('email', with: 'bob@gmail.com')
    fill_in('password', with: 'password')
    fill_in('password_confirmation', with: 'password')
    click_button('Submit')
  end

end
