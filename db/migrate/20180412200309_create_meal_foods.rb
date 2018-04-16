class CreateMealFoods < ActiveRecord::Migration[5.2]
  def change
  	create_table :meal_foods do |t|
  		t.integer :meal_id
  		t.integer :food_id 
  		t.float :food_servings 
  	end 
  end
end
