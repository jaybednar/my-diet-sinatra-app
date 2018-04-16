class Diet < ActiveRecord::Base
	belongs_to :user 
	
	has_many :diet_meals 
	has_many :meals, through: :diet_meals 

	after_initialize :default_values

	def create(params = nil)
		self.protein ||= 0.0
		self.carbs ||= 0.0
		self.fat ||= 0.0
		self.kcal ||= 0.0
	end 

	def calculate_macros
		self.diet_protein
		self.diet_carbs
		self.diet_fat
		self.diet_kcal
		self.save
	end 

	def diet_protein
		self.meals.each do |meal|
			self.protein += meal.protein
		end 
	end 

	def diet_carbs
		self.meals.each do |meal|
			self.carbs += meal.carbs
		end 
	end 

	def diet_fat
		self.meals.each do |meal|
			self.fat += meal.fat
		end 
	end 

	def diet_kcal
		self.meals.each do |meal|
			self.kcal += meal.kcal
		end 
	end 

	def slug 
		self.name.downcase.gsub(" ", "-")
	end 

	def self.find_by_slug(slug) 
		diet_date = slug.gsub("/", " ")
		self.all.detect{|diet| diet.date == diet_date}
	end 

	private

    def default_values
	    self.protein ||= 0.0
			self.carbs ||= 0.0
			self.fat ||= 0.0
			self.kcal ||= 0.0
    end
    

end 