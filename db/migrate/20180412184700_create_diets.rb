class CreateDiets < ActiveRecord::Migration[5.2]
  def change
  	create_table :diets do |t|
  		t.string :date
  		t.float :protein
  		t.float :carbs
  		t.float :fat 
  		t.integer :kcal
  		t.integer :user_id 
  	end 
  end
end
