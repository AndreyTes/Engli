class User < ApplicationRecord
# - includes / extends
include SharedMethods
include PublicActivity::Model
tracked 
  
# - Gems
devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable

# - Associations
has_many :phrases
has_many :examples

# - Validates
validates :username, presence: true, uniqueness: true 
  
def has_new_notifications?
  PublicActivity::Activity.where(recipient_id: self.id, readed: false).any?
end
end         