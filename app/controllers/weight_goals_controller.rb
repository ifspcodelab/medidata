class WeightGoalsController < ApplicationController
    layout 'internal'
        
        before_action :authenticate_user!
        before_action :block_crossprofile_access
        before_action :recover_profile
      
        def index
          # @weight_goal = @profile.weight_goal
          @weight_goal = WeightGoal.new
        end
      
        def new; end
      
        def edit
          @weight_goal = WeightGoal.find(params[:id])
        end
      
        def create
          @weight_goal = WeightGoal.new(weight_goal_params)
      
          @weight_goal.profile = @profile
      
          if @weight_goal.save
            flash[:success] = 'Weight Goal registered sucessfully'
            redirect_to profile_weight_goals_path(profile_email: @profile.email)
          else
            render 'new'
          end
        end
      
        def update
          @weight_goal = WeightGoal.find(params[:id])
      
          if @weight_goal.update(weight_goal_params)
            flash[:success] = 'Weight Goal updated sucessfully'
            redirect_to profile_weight_goals_path(profile_email: @weight.profile.email)
          else
            render 'edit'
          end
        end
      
        def destroy
          @weight_goal = WeightGoal.find(params[:id])
      
          profile_email = @weight_goal.profile.email
      
          @weight_goal.destroy
      
          redirect_to profile_weight_goals_path(profile_email: profile_email)
        end
      
        private
      
        def weight_goal_params
          params.require(:weight_goal).permit(:value, :date)
        end
      end
