require 'spec_helper'

describe 'Diet' do 
	before do 
		@user = User.create(:username => "test 123", :email => "test123@aol.com", :password => "test")
		@food = Food.create(name: "Chicken Breast", serving_size: "4 oz", protein: 26, carbs: 0, fat: 2)
		@food.food_calories
		@meal = Meal.create(name: "Meal1")
		@meal.add_food(@food, 2)
		@meal.calculate_macros
		@diet = Diet.create(name: "Diet1", goal: "Maintenance", user_id: @user.id, protein: @meal.protein, carbs: @meal.carbs, fat: @meal.fat, kcal: @meal.kcal)
	end 
	it 'has a name attribute' do
		expect(@diet.name).to eq("Diet1")
	end 

	it 'has a goal attribute' do
		expect(@diet.goal).to eq("Maintenance")
	end 

	it 'has a user_id attribute' do
		expect(@diet.user_id).to eq(@user.id)
	end 

	it 'has a protein attribute' do
		expect(@diet.protein).to eq(52)
	end 
	
	it 'has a carbs attribute' do
		expect(@diet.carbs).to eq(0)
	end 
	
	it 'has a fat attribute' do
		expect(@diet.fat).to eq(4)
	end 

	it 'has a kcal attribute' do
		expect(@diet.kcal).to eq(244)
	end 
end 