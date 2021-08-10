class Phrase < ApplicationRecord
# - includes / extends
include SharedMethods
extend FriendlyId
include PublicActivity::Model
tracked 

# - Gems
friendly_id :phrase, use: :slugged
acts_as_votable
  
# - Associations
belongs_to :user
has_many :examples, dependent: :destroy
accepts_nested_attributes_for :examples, allow_destroy: true

# - Validates
validates :phrase, presence: true, uniqueness: true
validates :translation, :user_id, presence: true
validates :category, inclusion: { in: %w(Actions Time Productivity Apologies),
  message: "%{value} is not a valid categoty" }
enum category: {Actions: 0, Time: 1, Productivity: 2, Apologies: 3, Common: 4}
end
