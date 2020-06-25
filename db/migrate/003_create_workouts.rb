class CreateWorkouts < ActiveRecord::Migration[6.0]
    def change
      create_table :workouts do |t|
        t.string :title
        t.text :description
        t.integer :length
        t.string :difficulty
        t.integer :trainer_id
        t.integer :user_id
  
        t.timestamps
      end
    end
  end