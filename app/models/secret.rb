require 'bcrypt'

class Secret < ApplicationRecord
  attr_encrypted :body,
    mode: :per_attribute_iv,
    key: Rails.application.credentials.secret_body_key.byteslice(0, 32),
    algorithm: 'aes-256-cbc'

  # hash the password before we save it. we will later compare the hashes to
  # make sure the passwords match.
  before_save { |secret| secret.password = BCrypt::Password.create(self.password) }

end