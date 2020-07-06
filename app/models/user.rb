class User < ApplicationRecord
    validates :username, uniqueness: true
    validates :password, length: { in: 6..100 }
    has_secure_password
    has_many :workouts
    has_many :trainers, :through => :workouts


    # def self.create_with_omniauth(auth)
    #     create! do |user|
    #       user.provider = auth["provider"]
    #       user.uid = auth["uid"]
    #       user.name = auth["info"]["nickname"]
    #     end
    # end
end
