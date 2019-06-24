class WeightGoalsController < ApplicationController
    layout 'internal'
        before_action :authenticate_user!
        before_action :block_crossprofile_access
        before_action :recover_profile
      
      
        def new; end
      
        def edit
          @weight_goal = @profile.weight_goal
        end
      
        def create
          @weight_goal = WeightGoal.new(weight_goal_params)
      
          @weight_goal.profile = @profile
      
          if @weight_goal.save
            flash[:success] = 'Weight Goal registered sucessfully'
            redirect_to profile_weights_path(profile_email: @profile.email)
          else
            render 'new'
          end
        end
      
        def update
          @weight_goal = @profile.weight_goal
      
          if @weight_goal.update(weight_goal_params)
            flash[:success] = 'Weight Goal updated sucessfully'
            redirect_to profile_weights_path(profile_email: @weight_goal.profile.email)
          else
            render 'edit'
          end
        end
      
        def destroy
          @weight_goal = @profile.weight_goal
      
          profile_email = @weight_goal.profile.email
      
          @weight_goal.destroy
      
          redirect_to profile_weights_path(profile_email: @profile.email)
        end
      
        private
      
        def weight_goal_params
          params.require(:weight_goal).permit(:value, :date)
        end
      end
