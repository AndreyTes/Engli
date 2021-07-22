class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :phrases
  validates :username,  :presence => true  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
  def author?(user)
    self.user == user
  end
end         