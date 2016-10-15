class Employee < ActiveRecord::Base
	belongs_to :sector
	belongs_to :department
	
	def admin?
    	admin
  	end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    

  validates_presence_of :name, message: "cant't be blank"
  validates_presence_of :code, message: "cant't be blank"
end
