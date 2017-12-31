require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  let(:user) { create(:user, email: "test@bloci.com", password: "zippob") }
  let(:wiki) { create(:wiki, title: "Test Wiki", body: "This is a dummy test wiki entry", private: false, user: user) }
  let(:collaborator) { Collaborator.create!(user: user, wiki: wiki) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:wiki) }
end
