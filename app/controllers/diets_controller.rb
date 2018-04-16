class DietsController < ApplicationController

	get '/diets' do 
		if logged_in?
			@diets = current_user.diets.all 
			erb :'/index' 
		else 
			redirect to '/login'
		end 
	end 

	get '/diets/new' do 
		if logged_in?
			erb :'/diets/new'
		else 
			redirect to '/login'
		end 
	end 

	post '/diets' do 
		d = Date.today
		@date = d.strftime("%-m/%-d/%Y")
		@diet = Diet.create(date: @date)
		@diet.user = current_user
		@diet.save 
		redirect to "/diets/#{@diet.slug}"
	end 

	get '/diets/:slug' do 
		if logged_in?
			@diet = Diet.find_by_slug(params[:slug])
			erb :'/diets/show'
		else 
			redirect to '/login'
		end 
	end  

end 