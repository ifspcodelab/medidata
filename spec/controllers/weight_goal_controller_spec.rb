require 'rails_helper'
require 'date'

RSpec.describe WeightGoalsController, type: :controller do
    before do
        @user = FactoryBot.create :user, email: 'joao@example.org'
        @existing_profile = FactoryBot.create :profile, email: 'joao@example.org', user: @user
        sign_in @user
      end
    
      after do
        sign_out(@user)
      end
    
      describe 'GET #new' do
        it 'returns a success response' do
          get :new, params: { profile_email: @existing_profile.email }
          expect(response).to be_successful
        end
    
        it 'render a new weight page' do
          get :new, params: { profile_email: @existing_profile.email }
          expect(response).to render_template(:new)
        end
      end
    
      describe 'GET #edit' do
        before do
          @existing_weight_goal = FactoryBot.create :weight_goal, profile: @existing_profile
        end
    
        it 'returns a success response' do
          get :edit, params: { profile_email: @existing_profile.email}
          expect(response).to be_successful
        end
    
        it 'returns an existing weight' do
          get :edit, params: { profile_email: @existing_profile.email}
          expect(assigns(:weight_goal)).to eq(@existing_weight_goal)
        end
    
        it 'returns an edit view' do
          get :edit, params: { profile_email: @existing_profile.email}
          expect(response).to render_template(:edit)
        end
      end
    
      describe 'POST #create' do
        context 'with valid params' do
          let(:valid_attributes) do
            { value: '70', date: 1.day.ago }
          end
    
          it 'creates a new Weight Goal' do
            post :create, params: {
                profile_email: @existing_profile.email,
                weight_goal: valid_attributes
            }
        
            @existing_profile.reload

            expect(@existing_profile.weight_goal).to_not be(nil)
          end
    
          it 'redirects to the weights page' do
            post :create, params: {
              profile_email: @existing_profile.email,
              weight_goal: valid_attributes
            }
    
            expect(response).to redirect_to(
              profile_weights_path(profile_email: @existing_profile.email)
            )
          end
        end
    
        context 'with invalid params' do
          let(:invalid_attributes) do
            { value: '' }
          end
    
          it "doesn't creates a new Weight Goal" do
            expect do
              post :create, params: {
                profile_email: @existing_profile.email,
                weight_goal: invalid_attributes
              }
            end.to_not change(@existing_profile.weights, :count)
          end
    
          it 'stay in the new weight' do
            post :create, params: {
              profile_email: @existing_profile.email,
              weight_goal: invalid_attributes
            }
    
            expect(response).to render_template(:new)
          end
        end
      end
    
      describe 'PUT #update' do
        before do
          @existing_weight_goal = FactoryBot.create :weight_goal, profile: @existing_profile
          @original_weight_goal_value = @existing_weight_goal.value
          @original_weight_goal_date = @existing_weight_goal.date
        end
    
        context 'with valid params' do
          let(:new_attributes) do
            {
              value: '65',
              date: '2018-06-25'
            }
          end
    
          it 'updates the requested profile' do
            put :update, params: { profile_email: @existing_profile.email,
                                   weight_goal: new_attributes }
            @existing_weight_goal.reload
    
            expect(@existing_weight_goal.value).to eq(new_attributes[:value].to_f)
            expect(@existing_weight_goal.date).to eq(new_attributes[:date].to_date)
            expect(@existing_weight_goal.profile).to eq(@existing_profile)
          end
    
          it 'redirects to the weights page' do
            put :update, params: { profile_email: @existing_profile.email,
                                   weight_goal: new_attributes }
    
            expect(response).to redirect_to(
              profile_weights_path(profile_email: @existing_profile.email)
            )
          end
        end
    
        context 'with invalid params' do
          let(:invalid_attributes) do
            { value: '' }
          end
    
          it "doesn't change the Weight" do
            put :update, params: { profile_email: @existing_profile.email,
                                   weight_goal: invalid_attributes }
            @existing_weight_goal.reload
    
            expect(@existing_weight_goal.value).to eq(@original_weight_goal_value)
            expect(@existing_weight_goal.date).to eq(@original_weight_goal_date)
            expect(@existing_weight_goal.profile).to eq(@existing_profile)
          end
    
          it 'stay in the edit weight goal' do
            put :update, params: { profile_email: @existing_profile.email,
                                   weight_goal: invalid_attributes }
    
            expect(response).to render_template(:edit)
          end
        end
      end
    
      describe 'DELETE #destroy' do
        before do
          @existing_weight = FactoryBot.create :weight_goal, profile: @existing_profile
        end
    
        it 'destroys the requested beight' do
          expect do
            delete :destroy, params: { profile_email: @existing_profile.email,
                                       id: @existing_weight_goal.to_param }
          end.to change(WeightGoal, :count).by(-1)
        end
    
        it 'redirects to the weights list' do
          delete :destroy, params: { profile_email: @existing_profile.email }
          expect(response).to redirect_to(
            profile_weights_path(profile_email: @existing_profile.email)
          )
        end
      end
end
