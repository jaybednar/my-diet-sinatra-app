class CreateFoods < ActiveRecord::Migration[5.2]
  def change
  	create_table :foods do |t|
  		t.string :name 
  		t.string :serving_size
  		t.float :protein
  		t.float :carbs
  		t.float :fat
  		t.integer :kcal
  	end 
  end
end
