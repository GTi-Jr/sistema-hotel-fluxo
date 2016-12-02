class Employee < ActiveRecord::Base
  belongs_to :sector
  belongs_to :department
  has_many :transactions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable

    validates :name, presence: true   
    validates :email, presence: true  
    validates :code, presence: true        
end
