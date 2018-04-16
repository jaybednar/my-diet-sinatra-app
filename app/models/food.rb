class Food < ActiveRecord::Base
	has_many :meal_foods
	has_many :meals, through: :meal_foods 
	
	def create(params = nil)
		self.protein ||= 0.0
		self.carbs ||= 0.0
		self.fat ||= 0.0
		self.kcal ||= 0.0
	end 
	
	def food_kcal(servings = 1)
		total_protein = self.protein * servings 
		total_carbs = self.carbs * servings
		total_fat = self.fat * servings
		self.kcal = ((total_protein * 4) + (total_carbs * 4) + (total_fat * 9))
		self.save
	end 

	def slug 
		self.name.downcase.gsub(" ", "-")
	end 

	def self.find_by_slug(slug) 
		food_name = slug.gsub("-", " ")
		self.all.detect{|food| food.name.downcase == food_name}
	end 
end 