module SignInSupport
  def sign_in(user)
    visit signup_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password
    find('input[name="commit"]').click
  end
end
