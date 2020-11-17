class User < ActiveRecord::Base
  
  def self.say
    puts 'hello'
  end
  
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, :length => { :minimum => 8 }

  def self.authenticate_with_credentials(email, password)
    email = email.downcase.strip
    user = self.find_by_email(email)
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(password)
      user
    else
      nil
    end

  end
end
