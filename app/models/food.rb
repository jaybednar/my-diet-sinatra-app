class Food < ActiveRecord::Base
	# belongs_to :creator, :class_name "User"
	# has_many :users
	
	has_many :meal_foods
	has_many :meals, through: :meal_foods 
	
	def create(params = nil)
		self.protein ||= 0.0
		self.carbs ||= 0.0
		self.fat ||= 0.0
		self.kcal ||= 0.0
	end 
	
	def food_kcal
		# binding.pry
		kcal = ((self.protein * 4) + (self.carbs * 4) + (self.fat * 9))
		self.update(kcal: kcal)
	end 

	def slug 
		self.name.downcase.gsub(" ", "-")
	end 

	def self.find_by_slug(slug) 
		food_name = slug.gsub("-", " ")
		self.all.detect{|food| food.name.downcase == food_name}
	end 
end 