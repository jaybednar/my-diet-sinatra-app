  @user = User.create(username: "jb", email: "jb@jb.com", password: "jjj")

foods_list = {
	"Chicken Breast" => {
		serving_size: "4 oz",
		protein: 26,
		carbs: 0,
		fat: 2
	},
	"Tuna" => {
		serving_size: "3 oz(1 can dry)",
		protein: 18,
		carbs: 0,
		fat: 0.5
	},
	"Eggs (Whole)" => {
	serving_size: "1 Egg",
	protein: 6,
	carbs: 0,
	fat: 4.5
	},
	"Egg Whites" => {
	serving_size: "4 oz",
	protein: 12.5,
	carbs: 0,
	fat: 0
	},
	"90/10 Ground Beef" => {
	serving_size: "4 oz",
	protein: 24,
	carbs: 0,
	fat: 10
	},
	"Oatmeal" => {
	serving_size: "1/2 cup",
	protein: 5,
	carbs: 27.5,
	fat: 2.5
	},
	"Jasmine Rice" => {
	serving_size: "1/2 cup",
	protein: 4,
	carbs: 44,
	fat: 0
	},
	"Potato" => {
	serving_size: "4 oz",
	protein: 2,
	carbs: 24,
	fat: 0
	},
	"Blueberries" => {
	serving_size: "1/2 cup",
	protein: 0,
	carbs: 10,
	fat: 0
	},
	"Orange" => {
	serving_size: "1 Orange",
	protein: 0,
	carbs: 20,
	fat: 0
	},
	"Natural Peanut Butter" => {
	serving_size: "2 tbsp",
	protein: 7,
	carbs: 7,
	fat: 18
	},
	"Coconut Oil" => {
	serving_size: "1 tbsp",
	protein: 0,
	carbs: 0,
	fat: 15
	},
	"Avocado Oil" => {
	serving_size: "1 tbsp",
	protein: 0,
	carbs: 0,
	fat: 14
	},
	"Extra Virgin Olive Oil" => {
	serving_size: "1 tbsp",
	protein: 0,
	carbs: 0,
	fat: 14
	},
	"Greek Yogurt" => {
	serving_size: "1/2 cup",
	protein: 11.5,
	carbs: 4.5,
	fat: 0
	},
	"Whey Protein" => {
	serving_size: "1 scoop",
	protein: 24,
	carbs: 2,
	fat: 2
	},
	"Cream of Rice" => {
	serving_size: "1/4 cup",
	protein: 4,
	carbs: 36,
	fat: 0
	},
	"Maltodextrin" => {
	serving_size: "1/4 cup",
	protein: 0,
	carbs: 30,
	fat: 0
	},
	"Cheese" => {
	serving_size: "1/4 cup",
	protein: 6,
	carbs: 0,
	fat: 8
	},
	"Fish Oil" => {
	serving_size: "1 capsule",
	protein: 0,
	carbs: 0,
	fat: 1
	},
}

foods_list.each do |name, food_hash|

	f = Food.create
	f.name = name 
	f.user = @user 
	
	food_hash.each do |macro, amount|
		f[macro] = amount 
	end 

	f.food_kcal
end 


# binding.pry
meals_list = {
	"Breakfast" => {
		food_ids: [
							[Food.find_by(name: "Eggs (Whole)"), 3],
							[Food.find_by(name: "Oatmeal"), 1],
							[Food.find_by(name: "Whey Protein"), 1]
							]
	},
	"Lunch" => {
		food_ids: [
			[Food.find_by(name: "Tuna"), 2],
			[Food.find_by(name: "Jasmine Rice"), 1],
			[Food.find_by(name: "Avocado Oil"), 1]
		]
	},
	"Dinner" => {
		food_ids: [
			[Food.find_by(name: "Chicken Breast"), 2], 
			[Food.find_by(name: "Potato"), 2],
			[Food.find_by(name: "Extra Virgin Olive Oil"), 1]
		]
	}
}


meals_list.each do |name, meal_hash|
	m = Meal.create
	m.name = name 
	meal_hash[:food_ids].each do |meal|
		m.add_food(meal[0], meal[1])
	end 
	
	# m.food_ids = meal_hash[:food_ids]
	m.calculate_macros
end 


@d = Diet.create(name: "Diet1", goal: "Maintenance", user_id: @user.id)
@protein = 0
@carbs = 0
@fat = 0
@kcal = 0

Meal.all.each do |meal| 
	@d.meals << meal
end 

@d.calculate_macros


































