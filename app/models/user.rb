class User < ApplicationRecord
    has_many :decks
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }
    validates :email, uniqueness: { case_sensitive: false }
    
    has_many :recieved_follows, foreign_key: :followed_id, class_name: "Follow"
    has_many :followers, through: :recieved_follows, source: :follower

    has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
    has_many :followings, through: :given_follows, source: :followed

    #helper method to allow a user to follow another user
    def follow(user)
        Follow.create(follower: self, followed: user)
    end
end
