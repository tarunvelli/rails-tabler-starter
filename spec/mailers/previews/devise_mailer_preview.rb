# frozen_string_literal: true

# visit http://localhost:3000/rails/mailers/
class DeviseMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    Devise::Mailer.confirmation_instructions(User.first, 'faketoken')
  end

  def email_changed
    Devise::Mailer.email_changed(User.first)
  end

  def password_changed
    Devise::Mailer.password_change(User.first)
  end

  def invitation_instructions
    Devise::Mailer.invitation_instructions(User.first, 'faketoken')
  end

  def reset_password_instructions
    Devise::Mailer.reset_password_instructions(User.first, 'faketoken')
  end

  def unlock_instructions
    Devise::Mailer.unlock_instructions(User.first, 'faketoken')
  end
end
