class Phrase < ApplicationRecord
  include SharedMethods
  extend FriendlyId
  friendly_id :phrase, use: :slugged
  
  validates :phrase, presence: true, uniqueness: true
  validates :translation, presence: true, uniqueness: true
  
  validates :category, inclusion: { in: %w(Actions Time Productivity Apologies),
    message: "%{value} is not a valid categoty" }
  enum category: {Actions: 0, Time: 1, Productivity: 2, Apologies: 3, Common: 4}
  
  belongs_to :user
  has_many :examples, dependent: :destroy
  accepts_nested_attributes_for :examples, allow_destroy: true
end
