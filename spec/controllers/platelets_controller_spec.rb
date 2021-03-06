# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlateletsController, type: :controller do
  before do
    @user = FactoryBot.create :user, email: 'joao@example.org'
    sign_in @user
    @existing_profile = FactoryBot.create :profile, email: 'joao@example.org', user: @user
  end

  after do
    sign_out @user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: { profile_email: @existing_profile.email }
      expect(response).to be_successful
    end

    it 'returns a page with all platelets registered from an user' do
      get :index, params: { profile_email: @existing_profile.email }
      expect(assigns(:platelets)).to eq(@existing_profile.platelets)
    end

    it 'render a index page' do
      get :index, params: { profile_email: @existing_profile.email }
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { profile_email: @existing_profile.email }
      expect(response).to be_successful
    end

    it 'render a new Platelets page' do
      get :new, params: { profile_email: @existing_profile.email }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before do
      @existing_platelet = FactoryBot.create :platelet, profile: @existing_profile
    end

    it 'returns a success response' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_platelet.id }
      expect(response).to be_successful
    end

    it 'returns an existing platelet' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_platelet.id }
      expect(assigns(:platelet)).to eq(@existing_platelet)
    end

    it 'returns an edit view' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_platelet.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) do
        { erythrocyte: 1, hemoglobin: 2, hematocrit: 3, vcm: 4, hcm: 5, chcm: 6, rdw: 7, leukocytep: 8, neutrophilp: 9, eosinophilp: 10,
          basophilp: 11, lymphocytep: 12,  monocytep: 13, leukocyteul: 14, neutrophilul: 15, eosinophilul: 16, basophilul: 17,
          lymphocyteul: 18, monocyteul: 19, total: 20 }
      end

      it 'creates a new Platelet Register' do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            platelet: valid_attributes
          }
        end.to change(@existing_profile.platelets, :count).by(1)
      end

      it 'redirects to the platelets page' do
        post :create, params: {
          profile_email: @existing_profile.email,
          platelet: valid_attributes
        }
        expect(response).to redirect_to(profile_platelets_path(profile_email: @existing_profile.email))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { erythrocyte: '', hemoglobin: '', hematocrit: '', vcm: '', hcm: '', chcm: '', rdw: '', leukocytep: '', neutrophilp: '', eosinophilp: '',
          basophilp: '', lymphocytep: '', monocytep: '', leukocyteul: '', neutrophilul: '', eosinophilul: '', basophilul: '',
          lymphocyteul: '', monocyteul: '', total: '' }
      end

      it "doesn't creates a new platelets" do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            platelet: invalid_attributes
          }
        end.to_not change(@existing_profile.platelets, :count)
      end

      it 'stay in the new platelets' do
        post :create, params: {
          profile_email: @existing_profile.email,
          platelet: invalid_attributes
        }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before do
      @existing_platelet = FactoryBot.create :platelet, profile: @existing_profile
      @original_platetet_erythrocyte = @existing_platelet.erythrocyte
      @original_platetet_hemoglobin = @existing_platelet.hemoglobin
      @original_platetet_hematocrit = @existing_platelet.hematocrit
      @original_platetet_vcm = @existing_platelet.vcm
      @original_platetet_hcm = @existing_platelet.hcm
      @original_platetet_chcm = @existing_platelet.chcm
      @original_platetet_rdw = @existing_platelet.rdw
      @original_platetet_leukocytep = @existing_platelet.leukocytep
      @original_platetet_neutrophilp = @existing_platelet.neutrophilp
      @original_platetet_eosinophilp = @existing_platelet.eosinophilp
      @original_platetet_basophilp = @existing_platelet.basophilp
      @original_platetet_lymphocytep = @existing_platelet.lymphocytep
      @original_platetet_monocytep = @existing_platelet.monocytep
      @original_platetet_leukocyteul = @existing_platelet.leukocyteul
      @original_platetet_neutrophilul = @existing_platelet.neutrophilul
      @original_platetet_eosinophilul = @existing_platelet.eosinophilul
      @original_platetet_basophilul = @existing_platelet.basophilul
      @original_platetet_lymphocyteul = @existing_platelet.lymphocyteul
      @original_platetet_monocyteul = @existing_platelet.monocyteul
      @original_platetet_total = @existing_platelet.total
    end

    context 'with valid params' do
      let(:new_attributes) do
        {
          erythrocyte: 1, hemoglobin: 2, hematocrit: 3, vcm: 4, hcm: 5, chcm: 6, rdw: 7, leukocytep: 8, neutrophilp: 9, eosinophilp: 10,
          basophilp: 11, lymphocytep: 12, monocytep: 13, leukocyteul: 14, neutrophilul: 15, eosinophilul: 16, basophilul: 17,
          lymphocyteul: 18, monocyteul: 19, total: 20
        }
      end

      it 'updates the requested profile' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_platelet.id, platelet: new_attributes }
        @existing_platelet.reload

        expect(@existing_platelet.erythrocyte).to eq(new_attributes[:erythrocyte])
        expect(@existing_platelet.hemoglobin).to eq(new_attributes[:hemoglobin])
        expect(@existing_platelet.hematocrit).to eq(new_attributes[:hematocrit])
        expect(@existing_platelet.vcm).to eq(new_attributes[:vcm])
        expect(@existing_platelet.hcm).to eq(new_attributes[:hcm])
        expect(@existing_platelet.chcm).to eq(new_attributes[:chcm])
        expect(@existing_platelet.rdw).to eq(new_attributes[:rdw])
        expect(@existing_platelet.leukocytep).to eq(new_attributes[:leukocytep])
        expect(@existing_platelet.neutrophilp).to eq(new_attributes[:neutrophilp])
        expect(@existing_platelet.eosinophilp).to eq(new_attributes[:eosinophilp])
        expect(@existing_platelet.basophilp).to eq(new_attributes[:basophilp])
        expect(@existing_platelet.lymphocytep).to eq(new_attributes[:lymphocytep])
        expect(@existing_platelet.monocytep).to eq(new_attributes[:monocytep])
        expect(@existing_platelet.leukocyteul).to eq(new_attributes[:leukocyteul])
        expect(@existing_platelet.neutrophilul).to eq(new_attributes[:neutrophilul])
        expect(@existing_platelet.eosinophilul).to eq(new_attributes[:eosinophilul])
        expect(@existing_platelet.basophilul).to eq(new_attributes[:basophilul])
        expect(@existing_platelet.lymphocyteul).to eq(new_attributes[:lymphocyteul])
        expect(@existing_platelet.monocyteul).to eq(new_attributes[:monocyteul])
        expect(@existing_platelet.total).to eq(new_attributes[:total])
        expect(@existing_platelet.profile).to eq(@existing_profile)
      end

      it 'redirects to the platelets page' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_platelet.id, platelet: new_attributes }

        expect(response).to redirect_to(profile_platelets_path(profile_email: @existing_profile.email))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { erythrocyte: '', hemoglobin: '', hematocrit: '', vcm: '', hcm: '', chcm: '', rdw: '', leukocytep: '',
          neutrophilp: '', eosinophilp: '', basophilp: '', lymphocytep: '',
          monocytep: '', leukocyteul: '', neutrophilul: '', eosinophilul: '',
          basophilul: '', lymphocyteul: '', monocyteul: '', total: '' }
      end

      it "doesn't change the platelet" do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_platelet.id, platelet: invalid_attributes }
        @existing_platelet.reload
        expect(@existing_platelet.erythrocyte).to eq(@original_platetet_erythrocyte)
        expect(@existing_platelet.hemoglobin).to eq(@original_platetet_hemoglobin)
        expect(@existing_platelet.hematocrit).to eq(@original_platetet_hematocrit)
        expect(@existing_platelet.vcm).to eq(@original_platetet_vcm)
        expect(@existing_platelet.hcm).to eq(@original_platetet_hcm)
        expect(@existing_platelet.chcm).to eq(@original_platetet_chcm)
        expect(@existing_platelet.rdw).to eq(@original_platetet_rdw)
        expect(@existing_platelet.leukocytep).to eq(@original_platetet_leukocytep)
        expect(@existing_platelet.neutrophilp).to eq(@original_platetet_neutrophilp)
        expect(@existing_platelet.eosinophilp).to eq(@original_platetet_eosinophilp)
        expect(@existing_platelet.basophilp).to eq(@original_platetet_basophilp)
        expect(@existing_platelet.lymphocytep).to eq(@original_platetet_lymphocytep)
        expect(@existing_platelet.monocytep).to eq(@original_platetet_monocytep)
        expect(@existing_platelet.leukocyteul).to eq(@original_platetet_leukocyteul)
        expect(@existing_platelet.neutrophilul).to eq(@original_platetet_neutrophilul)
        expect(@existing_platelet.eosinophilul).to eq(@original_platetet_eosinophilul)
        expect(@existing_platelet.basophilul).to eq(@original_platetet_basophilul)
        expect(@existing_platelet.lymphocyteul).to eq(@original_platetet_lymphocyteul)
        expect(@existing_platelet.monocyteul).to eq(@original_platetet_monocyteul)
        expect(@existing_platelet.total).to eq(@original_platetet_total)
        expect(@existing_platelet.profile).to eq(@existing_profile)
      end

      it 'stay in the edit platelet' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_platelet.id, platelet: invalid_attributes }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @existing_platelet = FactoryBot.create :platelet, profile: @existing_profile
    end
    it 'destroys the requested platelets' do
      expect do
        delete :destroy, params: { profile_email: @existing_profile.email, id: @existing_platelet.to_param }
      end.to change(Platelet, :count).by(-1)
    end

    it 'redirects to the platelets list' do
      delete :destroy, params: { profile_email: @existing_profile.email, id: @existing_platelet.to_param }
      expect(response).to redirect_to(profile_platelets_path(profile_email: @existing_profile.email))
    end
  end
end
