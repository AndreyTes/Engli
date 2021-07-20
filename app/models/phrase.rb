class Phrase < ApplicationRecord
  validates :phrase, presence: true, uniqueness: true
  validates :translation, presence: true, uniqueness: true
end
