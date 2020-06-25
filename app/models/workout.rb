class Workout < ApplicationRecord
    validates :title, presence: {message: "Workout must have a title"}
    validates :length, presence: {message: "Enter workout length in minutes"}
    validates :description, presence: {message: "Provide a description for this workout"}
    validates :difficulty, presence: {message: "Provide a difficulty level for this workout"}
    belongs_to :trainer
    belongs_to :user
end