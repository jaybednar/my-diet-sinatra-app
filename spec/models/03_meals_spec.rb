require 'spec_helper' 

describe 'Meal' do 
	before do 
		@food1 = Food.create(name: "Chicken Breast", serving_size: "4 oz", protein: 26, carbs: 0, fat: 2)
		@food1.food_calories
		@food2 = Food.create(name: "Jasmine Rice", serving_size: "1/2 cup", protein: 4, carbs: 44, fat: 0)
		@food2.food_calories
		@meal = Meal.create(name: "Meal1")
		@meal.add_food(@food1, 2)
		@meal.add_food(@food2, 1)
		@meal.calculate_macros
	end 

	it 'has a name attribute' do
		expect(@meal.name).to eq("Meal1")
	end 

	it 'has foods attribute' do 
		expect(@meal.foods.count).to eq(3)
		expect(@meal.foods.first.name).to eq("Chicken Breast")
		expect(@meal.foods.last.name).to eq("Jasmine Rice")
	end 

	it 'has a protein attribute' do
		expect(@meal.protein).to eq(56)
	end 
	
	it 'has a carbs attribute' do
		expect(@meal.carbs).to eq(44)
	end 
	
	it 'has a fat attribute' do
		expect(@meal.fat).to eq(4)
	end 

	it 'has a kcal attribute' do
		expect(@meal.kcal).to eq(436)
	end 

	it 'does not change macros of food item' do 
		expect(@food1.protein).to eq(26)
		expect(@food1.carbs).to eq(0)
		expect(@food1.fat).to eq(2)
		expect(@food1.kcal).to eq(122)
		expect(@food2.protein).to eq(4)
		expect(@food2.carbs).to eq(44)
		expect(@food2.fat).to eq(0)
		expect(@food2.kcal).to eq(192)
	end 
end 



