class Example < ApplicationRecord
  
include SharedMethods
include PublicActivity::Model
tracked

acts_as_votable

belongs_to :phrase
belongs_to :user

validates :example, presence: true
validates_uniqueness_of :example
end
