class User < ApplicationRecord
  validates :name,  presence: true, length: {maximum: Settings.users.max_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.users.max_pass},
    format: {with: VALID_EMAIL_REGEX},uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.users.min_pass}

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  private

  def downcase_email
    email.downcase!
  end
end
