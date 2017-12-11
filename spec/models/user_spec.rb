require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, email: 'test@bloc.io', password: 'password') }

  it { is_expected.to have_many(:wikis) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }

  describe "user entry" do
    it "should contain proper email address" do
      expect(user.email).to eq('test@bloc.io')
    end

    it "should contain proper password" do
      expect(user.password).to eq('password')
    end
  end
end
