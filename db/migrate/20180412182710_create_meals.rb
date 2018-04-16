class CreateMeals < ActiveRecord::Migration[5.2]
  def change
  	create_table :meals do |t|
  		t.string :name
  		t.float :protein 
  		t.float :carbs 
  		t.float :fat 
  		t.integer :kcal 
  	end 
  end
end
