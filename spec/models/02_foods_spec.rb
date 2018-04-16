require 'spec_helper' 

describe 'Food' do 
	before do 
		@food = Food.create(name: "Chicken Breast", serving_size: "4 oz", protein: 26, carbs: 0, fat: 2)
		@food.food_calories
	end 
	it 'has a name attribute' do 
		expect(@food.name).to eq("Chicken Breast")
	end 

	it 'has a protein attribute' do
		expect(@food.protein).to eq(26)
	end 
	
	it 'has a carbs attribute' do
		expect(@food.carbs).to eq(0)
	end 
	
	it 'has a fat attribute' do
		expect(@food.fat).to eq(2)
	end 

	it 'has a kcal attribute' do
		expect(@food.kcal).to eq(122)
	end 
end 

