require "rails_helper"

RSpec.describe User, :type => :model do
  let(:user) { FactoryGirl.create :user }

  describe 'valid object' do
    context 'validate user' do
      it 'creates a new user with valid attribute' do
        expect(user).to be_valid
      end
    end

    context 'validate email' do
      it 'requires a email address' do
        user.email = nil
        expect(user).to_not be_valid
      end

      it 'must valid email address' do
        user.email = 'invalid'
        expect(user).to_not be_valid
      end

      it 'duplicate email' do
        other_user = create(:user)
        duplicate_user = other_user.dup
        expect(duplicate_user).not_to be_valid
      end
    end

    context 'Validate password' do
      it 'requires a password' do
        user.password = nil
        expect(user).to_not be_valid
      end

      it 'requires matching password and password_confirmation' do
        user.password = 'invalid'
        expect(user).to_not be_valid
      end

      it 'ignore a weakness password' do
        short_pass = '12345'
        user.password = short_pass
        expect(user).to_not be_valid
      end
    end
  end

  describe 'Valid function' do
    context 'update password' do
      it "Update with password" do
        new_pass = '123456789'
        user_params = {password: new_pass, password_confirmation: new_pass, email: user.email}
        user.update_check_password(user_params)
        expect(user.password).to eq(new_pass)
      end
    end
  end
end
