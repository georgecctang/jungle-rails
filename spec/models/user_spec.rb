require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "Validations" do

    it "is valid if all fields are valid" do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')
      expect(@user).to be_valid
    end
  
    it "is invalid if password is missing" do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')
      @user.password = nil
      expect(@user.save).to be false
      expect(@user.errors.messages[:password]).to include("can\'t be blank")
    end

    it "is invalid if password_confirmation is missing" do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'abcdefgh', password_confirmation: '')
      # @user.password_confirmation = nil
      expect(@user.save).to be false
      puts @user.errors.messages
      # expect(@user.errors.messages[:password_confirmation]).to include("can\'t be blank")
    end


  end

end
