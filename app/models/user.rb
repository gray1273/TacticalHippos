class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	devise :database_authenticatable, :registerable,
    	   :recoverable, :rememberable, :validatable
   	belongs_to :user_type, foreign_key: :user_type_id
   	has_many :sections, :through => :grader_sections

   	accepts_nested_attributes_for :user_type
end
