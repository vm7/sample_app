class Micropost < ActiveRecord::Base
  attr_accessible :content, :user_id
  attr_accessible :content
  
  
  belongs_to :user
  
  validates :content, :presence => true, :length => { :maximum => 240 }
  validates :user_id, :presence => true
  
  default_scope :order => 'microposts.created_at DESC'
  
  scope :from_users_followed_by, lambda { |users| followed_by(users) }
  
  private 
  
  def self.followed_by(user)
   followed_ids = %( SELECT followed_id FROM relationships WHERE follower_id = :user_id )
   where("user_id IN (#{followed_ids}) OR user_id= :user_id", :user_id => user )
  end
  
end
# == Schema Information
#
# Table name: microposts
#
#  id           :integer         not null, primary key
#  content      :string(255)
#  user_id      :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  like_counter :integer
#

