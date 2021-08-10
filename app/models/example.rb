class Example < ApplicationRecord
  
# - includes / extends
include SharedMethods
include PublicActivity::Model
tracked

# - Gems
acts_as_votable

# - Associations
belongs_to :phrase
belongs_to :user

# - Validates
validates :example, presence: true
validates_uniqueness_of :example
end
