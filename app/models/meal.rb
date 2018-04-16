class Meal < ActiveRecord::Base
	has_many :diet_meals 
	has_many :diets, through: :diet_meals

	has_many :meal_foods 
	has_many :foods, through: :meal_foods

	after_initialize :default_values


	def add_food(food, servings)
		servings.times do 
			self.foods << food 
		end 

		self.save 
	end 

	def calculate_macros
		self.meal_protein
		self.meal_carbs
		self.meal_fat
		self.meal_kcal
		self.save
	end 

	def meal_protein
		self.foods.each do |food|
			self.protein += food.protein
		end 
	end 

	def meal_carbs
		self.foods.each do |food|
			self.carbs += food.carbs
		end 
	end 

	def meal_fat
		self.foods.each do |food|
			self.fat += food.fat
		end 
	end 

	def meal_kcal
		self.foods.each do |food|
			self.kcal += food.kcal
		end 
	end 

	def slug 
		self.name.downcase.gsub(" ", "-")
	end 

	def self.find_by_slug(slug) 
		meal_name = slug.gsub("-", " ")
		self.all.detect{|meal| meal.name.downcase == meal_name}
	end 

	private

    def default_values
    self.protein ||= 0.0
		self.carbs ||= 0.0
		self.fat ||= 0.0
		self.kcal ||= 0.0
    end
    
end 