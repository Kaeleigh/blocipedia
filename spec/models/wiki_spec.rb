require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:wiki) { create(:wiki, title: "New Wiki Title", body: "New wiki body", private: false, user: user) }
  let(:user) { create(:user, email: "test@bloc.io", password: "password") }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:collaborators) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(10) }

  describe "attributes" do
    it "has title, body and private attributes" do
      expect(wiki).to have_attributes(title: "New Wiki Title", body: "New wiki body", private: false)
    end
  end
end
