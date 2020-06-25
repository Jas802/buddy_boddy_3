class Trainer < ApplicationRecord
    has_many :workouts
    has_many :users, :through => :workouts

    def most_difficult_workouts
        self.workouts.where ('difficulty >= 4')
    end

end