class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  mount_uploader :image, ImageUploader
  
  has_many :tweets
  has_many :relations
  has_many :followings, through: :relations, source: :follow
  has_many :revers_relations, class_name: 'Relation', foreign_key: 'follow_id'
  has_many :followers, through: :revers_relations, source: :user
  
  def follow(other_user)
    unless self == other_user
      self.relations.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relation = self.relations.find_by(follow_id: other_user.id)
    relation.destroy if relation
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_tweets
    Tweet.where(user_id: self.following_ids + [self.id])
  end  
end
