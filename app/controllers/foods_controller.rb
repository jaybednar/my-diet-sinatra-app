class FoodsController < ApplicationController

	get '/foods' do 
		if logged_in?
			@foods = Food.all 
			erb :'/foods/index'
		else 
			redirect to '/login'
		end 
	end 

	get '/foods/new' do 
		if logged_in?
			@foods = Food.all 
			erb :'/foods/new'
		else 
			redirect to '/login'
		end 
	end 

	post '/foods' do 
		if !params[:food][:name].empty? && !params[:food][:protein].empty? && !params[:food][:carbs].empty? && !params[:food][:fat].empty? 
			@food = Food.create(params[:food]).food_kcal
			redirect to '/foods'
		else 
			redirect to '/login'
		end 
	end 

	get '/foods/:slug' do 
		if logged_in?
			@food = Food.find_by_slug(params[:slug])
			erb :'/foods/show'
		else 
			redirect to '/login'
		end 
	end 

	get '/foods/:slug/edit' do 
		if logged_in?
			@food = Food.find_by_slug(params[:slug])
			erb :'/foods/edit'
		else 
			redirect to '/login' 
		end 
	end 

	patch '/foods/:slug' do
		if !params[:food][:name].empty? && !params[:food][:protein].empty? && !params[:food][:carbs].empty? && !params[:food][:fat].empty? 
			@food = Food.find_by_slug(params[:slug])
			@food.update(params[:food])
			@food.food_kcal
			@food.save 
			redirect to '/foods'
		else
			redirect to "/foods/#{params[:slug]}/edit"
		end 
	end 

	delete '/foods/:slug/delete' do 
		@food = Food.find_by_slug(params[:slug])
		@food.delete
		redirect to '/foods' 
	end 

end 