class Example < ApplicationRecord
  include SharedMethods
  belongs_to :phrase
  belongs_to :user
  validates :example, presence: true
  validates_uniqueness_of :example
  acts_as_votable
end
