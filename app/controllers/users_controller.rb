class UsersController < ApplicationController

	get '/signup' do 
		if logged_in? 
			@slug = User.find(session[user_id]).slug
			redirect to "/users/#{@slug}"
		else 
			erb :'/users/signup'
		end 
  end 

	post '/signup' do 
	 	if !params[:user][:username].empty? && !params[:user][:email].empty? && !params[:user][:password].empty?
			@user = User.create(params[:user])
	  	session[:user_id] = @user.id 
	  	redirect to "/users/#{@user.slug}"
	  else 
	  	redirect to '/signup'
	  end 
	end 

	get '/login' do 
  	if !logged_in?
  		erb :'users/login' 
  	else
  		@user = User.find(session[:user_id])
  		redirect to "/users/#{@user.slug}"
  	end 
  end 

  post '/login' do 
  	
  	if logged_in? 
  		@user = User.find(session[:user_id])
			redirect to "/users/#{@user.slug}"
  	else 
	  	@user = User.find_by(username: params[:username])
	  	if @user && @user.authenticate(params[:password])
	  		session[:user_id] = @user.id 
	  		redirect to "/users/#{@user.slug}"
	  	else 
	  		redirect to '/login'
	  	end 
	  end 
  end 

  get '/users/:slug' do 
	  if logged_in?
	  	@user = User.find_by_slug(params[:slug])
	  	erb :'/users/show'
	  else 
	  	redirect to '/login'
	  end 
	end 

	get '/logout' do 
  	if logged_in?
  		session.clear
  	end 
  	redirect to '/login' 
  end 


end 