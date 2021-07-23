class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include SharedMethods
  has_many :phrases
  has_many :examples
  validates :username, presence: true, uniqueness: true 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
end         