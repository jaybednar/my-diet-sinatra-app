class CreateFoods < ActiveRecord::Migration[5.2]
  def change
  	create_table :foods do |t|
  		t.string :name 
  		t.string :serving_size
  		t.float :protein
  		t.float :carbs
  		t.float :fat
  		t.integer :kcal
      t.integer :creator_id
  	end 
  end
end



# class CreateFoods < ActiveRecord::Migration[5.2]
#   def change
#     create_table :foods do |t|
#       t.string :name 
#       t.string :serving_size
#       t.float :protein
#       t.float :carbs
#       t.float :fat
#       t.integer :kcal
#       t.integer :creator_id
#       t.integer :foodable_id 
#       t.text :foodable_type
#     end 
#     add
#   end
# end

