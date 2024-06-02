require 'rails_helper'

RSpec.describe BodiesController, type: :controller do
  let(:valid_parts) { ["front-torso, front-thigh-right", "back-knee-left, back-shoulder-right"] }
  let(:valid_attributes_list) {
    valid_parts.map { |parts| { parts: parts } }
  }

  let!(:bodies) {
    valid_attributes_list.map { |attributes| Body.create!(attributes) }
  }

  describe "GET #index" do
    it "returns the created bodies" do
      get :index
      expect(assigns(:bodies)).to match_array(bodies)
    end
  end

  describe "GET #show" do
    it "returns the first body" do
      params = { "id" => bodies.first.id}
      get :show, params: params
      expect(assigns(:body).parts).to eq bodies.first.parts
    end
    it "returns the second body" do
      params = { "id" => bodies.second.id}
      get :show, params: params
      expect(assigns(:body).parts).to eq bodies.second.parts
    end
  end

  describe "GET #new" do
    it "creates a new body object, that is empty" do
      get :new
      puts :body
      expect(assigns(:body).parts).to eq nil
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a body, and returns the correct parts" do
        post :create, params: { body: valid_attributes_list[0] }
        expect(assigns(:body).parts).to eq valid_attributes_list[0][:parts]
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested body" do
      delete :destroy, params: { id: bodies.first.to_param }
      expect { Body.find(bodies.first.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "POST #body_symptoms" do
    it "returns the correct side and parts attributes" do
      get :body_symptoms, params: { side: "left", parts: "front-shoulder-left" }, format: :turbo_stream
      expect(assigns(:side)).to eq "left"
      expect(assigns(:link)).to eq "front-shoulder-left"
    end
  end
end
