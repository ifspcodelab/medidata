require 'rails_helper'

RSpec.describe WeightGoal, type: :model do
    describe 'Validations' do
        before do
          @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
        end
        it 'Should have current date if date was not informed' do
            weight_goal = WeightGoal.new(value: 60, profile: @existing_profile)
            expect(weight_goal.date.to_date).to eq(Time.now.to_date)
          end
      
    end
end
