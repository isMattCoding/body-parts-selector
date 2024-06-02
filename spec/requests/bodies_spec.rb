require 'rails_helper'

RSpec.describe BodiesController, type: :controller do
  let(:valid_attributes) {
    { parts: "front-torso, front-thigh-right",
      id: 1,
    }
  }

  let(:invalid_attributes) {
    { parts: "invalid-torso, invalid-thigh-right" }
  }

  let(:body) { Body.create! valid_attributes }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      params = { "id" => body.id}
      get :show, params: params
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Body" do
        expect {
          post :create, params: { body: valid_attributes }
        }.to change(Body, :count).by(1)
      end

      it "redirects to the root path" do
        post :create, params: { body: valid_attributes }
        expect(response).to redirect_to("/")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Body" do
        expect {
          post :create, params: { body: invalid_attributes }
        }.to change(Body, :count).by(0)
      end

      it "renders the new template" do
        post :create, params: { body: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested body" do
      body
      expect {
        delete :destroy, params: { id: body.to_param }
      }.to change(Body, :count).by(-1)
    end

    it "redirects to the bodies list" do
      delete :destroy, params: { id: body.to_param }
      expect(response).to redirect_to(root_path)
      expect(response).to have_http_status(:see_other)
    end
  end

  describe "POST #body_symptoms" do
    it "returns a success response" do
      get :body_symptoms, params: { side: "left", parts: "front-shoulder-left" }, format: :turbo_stream
      expect(response).to have_http_status(:ok)
    end
    it "returns a turbo stream response" do
      get :body_symptoms, params: { side: "left", parts: "front-shoulder-left" }, format: :turbo_stream
      expect(response.media_type).to eq Mime[:turbo_stream]
    end
  end
end
