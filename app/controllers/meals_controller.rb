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
			@foods_to_add = []
			@foods = Food.all 
			erb :'/meals/new'
		else 
			redirect to '/login'
		end 
	end 

	post '/meals' do 
		# binding.pry
		@foods = Food.all 

		if params.include?("add_to_meal")
			food = Food.find_by_slug(params[:foods][:food_1][:food_slug])
			add_to_meal = [food, params[:foods][:food_1][:food_servings]]
			@foods_to_add << add_to_meal
			# redirect to '/meals/new'
			erb :'/meals/new'
		else 

			if !params[:meal][:name].empty? 
				@meal = Meal.create(name: params[:meal][:name])

				params[:foods].each do |food_num, food_hash|
					# binding.pry
					food = Food.find_by_slug(food_hash[:food_slug])
					@meal.add_food(food, food_hash[:food_servings].to_i)
				end 
				
				@meal.calculate_macros

				redirect to '/meals'

			 
				redirect to '/meals/new'
			end 
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