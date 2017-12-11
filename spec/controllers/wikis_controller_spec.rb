require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:my_user) { create(:user, email: 'test@bloc.io', password: 'password') }
  let(:my_wiki) { create(:wiki, user: my_user) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_wiki] to @wikis" do
      get :index
      expect(assigns(:wikis)).to eq([my_wiki])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: my_wiki.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: { id: my_wiki.id }
      expect(response).to render_template :show
    end

    it "assigns my_wiki to @wiki" do
      get :show, params: { id: my_wiki.id }
      expect(assigns(:wiki)).to eq(my_wiki)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, params: { id: my_wiki.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, params: { id: my_wiki.id }
      expect(response).to render_template :new
    end

    it "instantiates @wiki" do
      get :new, params: { id: my_wiki.id }
      expect(assigns(:wiki)).not_to_be_nil
    end
  end

  describe "POST create" do
    it "increases num of Wikis by 1" do
      expect{ post :create, params: { wiki: { title: "New Wiki Title", body: "New Wiki Body", private: false } } }.to change(Wiki, :count).by(1)
    end

    it "assigns the new wiki to @wiki" do
      post :create, params: { wiki: { title: "New Wiki Title", body: "New Wiki Body", private: false } }
      expect(assigns(:wiki)).to eq Wiki.last
    end

    it "redirects to the new Wiki" do
      post :create, params: { wiki: { title: "New Wiki Title", body: "New Wiki Body", private: false } }
      expect(assigns(:wiki)).to redirect_to Wiki.last
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: my_wiki.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, params: { id: my_wiki.id }
      expect(response).to render_template :edit
    end

    it "assigns wiki to be updated to @wiki" do
      get :edit, params: { id: my_wiki.id }
      wiki_instance = assigns(:wiki)

      expect(wiki_instance.id).to eq my_wiki.id
      expect(wiki_instance.title).to eq my_wiki.title
      expect(wiki_instance.body).to eq my_wiki.body
    end
  end

  describe "PUT update" do
    it "updates wiki with expected attributes" do
      new_title = "New Wiki Title"
      new_body = "New wiki body"
      new_privacy_setting = true

      put :update, params: { id: my_wiki.id, wiki: { title: new_title, body: new_body, private: new_privacy_setting } }

      updated_wiki = assigns(:wiki)
      expect(updated_wiki.id).to eq my_wiki.id
      expect(updated_wiki.title).to eq new_title
      expect(updated_wiki.body).to eq new_body
      expect(updated_wiki.private).to eq new_privacy_setting
    end

    it "redirects to the updated wiki" do
      new_title = "New Wiki Title"
      new_body = "New wiki body"
      new_privacy_setting = true

      put :update, params: { id: my_wiki.id, wiki: { title: new_title, body: new_body, private: new_privacy_setting } }
      expect(response).to redirect_to my_wiki
    end
  end

  describe "DELETE destroy" do
    it "deletes the wiki" do
      delete :destroy, params: { id: my_wiki.id }
      count = Wiki.where({id: my_wiki.id}).size
      expect(count).to eq 0
    end

    it "redirects to wiki index" do
      delete :destroy, params: { id: my_wiki.id }
      expect(response).to redirect_to wikis_path
    end
  end
# closes RSpec
end
