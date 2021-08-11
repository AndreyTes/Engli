class User < ApplicationRecord
include SharedMethods
include PublicActivity::Model
tracked 
  
devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable

has_many :phrases
has_many :examples

validates :username, presence: true, uniqueness: true 
  
def has_new_notifications?
  PublicActivity::Activity.where(recipient_id: self.id, readed: false).any?
end

def public_activities
  PublicActivity::Activity.where(recipient_id: self.id)
end

end         