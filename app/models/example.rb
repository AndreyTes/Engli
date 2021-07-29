class Example < ApplicationRecord
  include SharedMethods
  include PublicActivity::Model
  tracked
  
  belongs_to :phrase
  belongs_to :user
  validates :example, presence: true
  validates_uniqueness_of :example
  acts_as_votable
end
