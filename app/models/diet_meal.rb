class DietMeal < ActiveRecord::Base
	belongs_to :diet
	belongs_to :meal 

end 