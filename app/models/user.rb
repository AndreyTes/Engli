class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include SharedMethods
  include PublicActivity::Model
  tracked 

  has_many :phrases
  has_many :examples
  validates :username, presence: true, uniqueness: true 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

def has_new_notifications?
  PublicActivity::Activity.where(recipient_id: self.id, readed: false).any?
end
        
end         