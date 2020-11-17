class User < ActiveRecord::Base
  has_secure_password

  validates :password,
    :length => { :minimum => 8, :if => :validate_password? },
    :confirmation => { :if => :validate_password? }

  private

  def validate_password?
    password.present? || password_confirmation.present?
  end

end
