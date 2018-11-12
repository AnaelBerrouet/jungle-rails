require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'should return true for all parameters set properly' do
      @user = User.new({
        first_name: 'Bob',
        last_name: 'Jenkins',
        email: "new@Test.com",
        password: "password",
        password_confirmation: "password"
      })
      expect(@user.valid?).to be true
    end

    it 'should return false for password != password_confirmation' do
      @user = User.new({
        first_name: 'Bob',
        last_name: 'Jenkins',
        email: "Test@Test.com",
        password: "password",
        password_confirmation: "NOTpassword"
      })
      expect(@user.valid?).to be false
    end

    it 'should return false for password parameter not set' do
      @user = User.new({
        first_name: 'Bob',
        last_name: 'Jenkins',
        email: "Test@Test.com",
        password_confirmation: "NOTpassword"
      })
      expect(@user.valid?).to be false
    end

    it 'should return false for password_confirmation parameter not set' do
      @user = User.new({
        first_name: 'Bob',
        last_name: 'Jenkins',
        email: "Test@Test.com",
        password: "password"
      })
      expect(@user.valid?).to be false
    end

    it 'should return false for email which is already in use' do
      @user = User.new({
        first_name: 'Bob',
        last_name: 'Jenkins',
        email: "tester@test.com",
        password: "password",
        password_confirmation: "password"
      })

      @user_with_same_email = @user.dup
      @user.save

      expect(@user_with_same_email.save).to be false
    end

    it 'should return false for email which is already in use (case sensitivity check)' do
      @user = User.new({
        first_name: 'Bob',
        last_name: 'Jenkins',
        email: "test@test.com",
        password: "password",
        password_confirmation: "password"
      })

      @user_with_same_email = @user.dup
      @user.email = "TEST@TEST.com"
      @user.email.downcase!
      @user.save
      expect(@user_with_same_email.save).to be false
    end

    it 'should return false for no first_name' do
      @user = User.new({
        last_name: 'Jenkins',
        email: "Test@Test.com",
        password: "1",
        password_confirmation: "password"
      })
      expect(@user.valid?).to be false
    end

    it 'should return false for no last_name' do
      @user = User.new({
        first_name: 'Bob',
        email: "Test@Test.com",
        password: "1",
        password_confirmation: "password"
      })
      expect(@user.valid?).to be false
    end

    it 'should return false for short password' do
      @user = User.new({
        first_name: 'Bob',
        last_name: 'Jenkins',
        email: "test@test.com",
        password: "1",
        password_confirmation: "password"
      })
      expect(@user.valid?).to be false
    end

  end

  describe '.authenticate_with_credentials' do

    it 'should return false if user is in db and login is correct' do

      @user = User.find_by_email("user@example.com")
      @user.password = "12345"
      expect(User.authenticate_with_credentials(@user.email, @user.password).nil?).to be false
    end

    it 'should return false if email has spaces' do
      expect(User.authenticate_with_credentials(" user@example.com ", "12345").nil?).to be false
    end

    it 'should return false if email has uppercase' do
      expect(User.authenticate_with_credentials(" USer@example.com ", "12345").nil?).to be false
    end

  end

end
