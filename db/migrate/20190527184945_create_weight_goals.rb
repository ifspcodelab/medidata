class CreateWeightGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :weight_goals do |t|

      t.timestamps
    end
  end
end
