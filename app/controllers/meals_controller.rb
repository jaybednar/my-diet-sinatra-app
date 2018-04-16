class MealsController < ApplicationController

	get '/meals' do 
		if logged_in?
			@meals = Meal.all 
			erb :'/meals/index'
		else 
			redirect to '/login'
		end 
	end 

	get '/meals/new' do 
		if logged_in?
			@foods = Food.all 
			erb :'/meals/new'
		else 
			redirect to '/login'
		end 
	end 

	post '/meals' do 
		
		if !params[:meal][:name].empty? 
			@meal = Meal.create(name: params[:meal][:name])

			params[:foods].each do |food_num, food_hash|
				# binding.pry
				food = Food.find_by_slug(food_hash[:food_slug])
				@meal.add_food(food, food_hash[:food_servings].to_i)
			end 
			
			@meal.calculate_macros

			redirect to '/meals'

		else 
			redirect to '/meals/new'
		end 
	end 

end 


# {params: { 
# 				foods: 
# 							{
# 							food_1: 
# 										{
# 											food_slug: "slug", servings: 2
# 											}
# 							}
# 				}
# }