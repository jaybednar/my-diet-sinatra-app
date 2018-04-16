class CreateDietMeals < ActiveRecord::Migration[5.2]
  def change
  	create_table :diet_meals do |t|
  		t.integer :diet_id
  		t.integer :meal_id
  	end 
  end
end
