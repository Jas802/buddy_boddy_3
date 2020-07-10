class Trainer < ApplicationRecord
    has_many :workouts
    has_many :users, :through => :workouts

    def most_difficult_workouts
        self.workouts.where ('difficulty >= 4')
    end

    def self.search(search)
       if search 
        where(['name LIKE ?', "%#{search}"])
        else
            Trainer.all
        end
    end
end