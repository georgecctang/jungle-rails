require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "Validations" do
  
    it "is invalid if password is an empty string" do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: '', password_confirmation: '')
      expect(@user.save).to be false
      expect(@user.errors.messages[:password]).to include("can\'t be blank")
    end

    it "is invalid if password_confirmation is an empty string" do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'abcdefgh', password_confirmation: '')
      expect(@user.save).to be false
      expect(@user.errors.messages[:password_confirmation]).to include("doesn\'t match Password")
    end

    it "is invalid if password_confirmation does not match password" do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'abcdefgh', password_confirmation: 'xxxxxxxx')
      expect(@user.save).to be false
      expect(@user.errors.messages[:password_confirmation]).to include("doesn\'t match Password")
    end

    it "is invalid if first_name is missing" do
      @user = User.new(first_name: '', last_name: 'Doe', email: 'test@test.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')
      expect(@user.save).to be false
      expect(@user.errors.messages[:first_name]).to include("can\'t be blank")
    end

    it "is invalid if last_name is missing" do
      @user = User.new(first_name: 'John', last_name: '', email: 'test@test.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')
      expect(@user.save).to be false
      expect(@user.errors.messages[:last_name]).to include("can\'t be blank")
    end

    it "is invalid if email is missing" do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: '', password: 'abcdefgh', password_confirmation: 'abcdefgh')
      expect(@user.save).to be false
      expect(@user.errors.messages[:email]).to include("can\'t be blank")
    end

    it "is invalid if password is shorter than 8 characters" do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'abcdefg', password_confirmation: 'abcdefg')
      expect(@user.save).to be false
      expect(@user.errors.messages[:password][0]).to include("is too short")
    end

    it "is valid if all fields are valid" do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')
      expect(@user).to be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    it "is invalid if email is missing" do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')
      @user.save
      @user_login = User.authenticate_with_credentials('', 'abcdefgh')
      expect(@user_login).to be_nil
      # puts @user_login.errors.messages
    end

    it "is invalid if password is incorrect" do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')
      @user.save
      @user_login = User.authenticate_with_credentials('test@test.com', 'xxxxxxxx')
      expect(@user_login).to be_nil
    end

    it "is valid if all fields are valid" do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')
      @user.save
      @user_login = User.authenticate_with_credentials('test@test.com', 'abcdefgh')
      expect(@user_login).not_to be_nil
    end

    it "is valid even when there are head and tail spaces in email " do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')
      @user.save
      @user_login = User.authenticate_with_credentials(' test@test.com  ', 'abcdefgh')
      expect(@user_login).not_to be_nil
    end

    it "is valid if the cases in email does not match exactly " do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')
      @user.save
      @user_login = User.authenticate_with_credentials('Test@tEst.coM', 'abcdefgh')
      expect(@user_login).not_to be_nil
    end


  end

end
