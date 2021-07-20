class Phrase < ApplicationRecord
  validates :phrase, presence: true, uniqueness: true
  validates :translation, presence: true, uniqueness: true
  validates :category, inclusion: { in: %w(Actions Time Productivity Apologies),
    message: "%{value} is not a valid categoty" }
  enum category: {Actions: 0, Time: 1, Productivity: 2, Apologies: 3, Common: 4}
  
end
