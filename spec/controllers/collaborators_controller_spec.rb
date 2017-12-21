require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
  let(:user) { create(:user, email: "test@bloci.com", password: "zippob") }
  let(:wiki) { create(:wiki, title: "Test Wiki", body: "This is a dummy test wiki entry", private: false, user: user) }

  describe 'POST create' do
    it "redirects to the wikis show view" do
      post :create, { wiki_id: wiki_id }
      expect(response).to redirect_to(wiki)
    end

    it "creates a collaborator for the input email and specific wiki" do
      expect(user.collaborators.find_by_wiki_id(wiki.id)).to be_nil
      post :create, { wiki_id: wiki_id }
      expect(user.collaborators.find_by_wiki_id(wiki.id)).not_to be_nil
    end
  end
# closes RSpec
end
