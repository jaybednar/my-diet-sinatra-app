require 'spec_helper'  

require 'spec_helper'  

describe "Signup Page" do 
	it 'loads the Signup Page' do 
		get '/signup' 
		expect(last_response.status).to eq(200) 
		expect(last_response.status).to eq("Create New Account")
	end 

	it 'signup directs user to User Homepage' do 
		params = {
        :username => "test 123",
        :email => "test123@test.com",
        :password => "test"
      }
      post '/signup', params
      expect(last_response.location).to include("/users/test-123")
    end

    it 'does not let a user sign up without a username' do
      params = {
        :username => "",
        :email => "test123@test.com",
        :password => "test"
      }
      post '/signup', params
      expect(last_response.location).to include('/signup')
    end

    it 'does not let a user sign up without an email' do
      params = {
        :username => "test 123",
        :email => "",
        :password => "test"
      }
      post '/signup', params
      expect(last_response.location).to include('/signup')
    end

    it 'does not let a user sign up without a password' do
      params = {
        :username => "test 123",
        :email => "test123@test.com",
        :password => ""
      }
      post '/signup', params
      expect(last_response.location).to include('/signup')
    end

    it 'does not let a logged in user view the signup page' do
      user = User.create(:username => "test 123", :email => "test123@test.com", :password => "test")
      params = {
        :username => "test 123",
        :email => "test123@test.com",
        :password => "test"
      }
      post '/signup', params
      session = {}
      session[:user_id] = user.id
      get '/signup'
      expect(last_response.location).to include('/users/test-123')
    end
end 

describe "Login Page" do 
	it 'loads the Login Page' do 
		get '/login' 
		expect(last_response.status).to eq(200) 
		expect(last_response.status).to eq("Login To Your Account")
	end 

	 it 'loads the User Homepage after login' do
	    user = User.create(:username => "tester 456", :email => "tester456@test.com", :password => "testing")
	    params = {
	      :username => "tester 456",
	      :password => "testing"
	    }
	    post '/login', params
	    expect(last_response.status).to eq(302)
	    follow_redirect!
	    expect(last_response.status).to eq(200)
	    expect(last_response.body).to include("Welcome,")
	  end

	  it 'does not let user view login page if already logged in' do
	    user = User.create(:username => "tester 456", :email => "tester456@test.com", :password => "testing")
	    params = {
	      :username => "tester 456",
	      :password => "testing"
	    }
	    post '/login', params
	    session = {}
	    session[:user_id] = user.id
	    get '/login'
	    expect(last_response.location).to include("/users/tester-456")
	  end
end 

describe "User Homepage" do 
	it 'loads the User Homepage' do 
		@user = User.create(:username => "another user", :email => "anotheruser@test.com", :password => "anothertest")
		@food = Food.create(name: "Chicken Breast", serving_size: "4 oz", protein: 26, carbs: 0, fat: 2)
		@food.food_calories
		@meal = Meal.create(name: "Meal1")
		@meal.add_food(@food, 2)
		@meal.calculate_macros
		@diet = Diet.create(name: "Diet1", goal: "Maintenance", user_id: @user.id, protein: @meal.protein, carbs: @meal.carbs, fat: @meal.fat, kcal: @meal.kcal)
		get "/users/#{@user.slug}"
		expect(last_response.status).to eq(200) 
		expect(last_response.body).to include("Diet1")
	end 
end 


  describe "logout" do
    it "lets a user logout if they are already logged in" do
      user = User.create(:username => "test 123", :email => "test123@test.com", :password => "test")
      params = {
        :username => "test 123",
        :email => "test123@test.com",
        :password => "test"
      }
      post '/login', params
      get '/logout'
      expect(last_response.location).to include("/login")
    end

    it 'does not let a user logout if not logged in' do
      get '/logout'
      expect(last_response.location).to include("/")
    end

    it 'does not load /tweets if user not logged in' do
      get '/tweets'
      expect(last_response.location).to include("/login")
    end

    it 'does load /users/:slug if user is logged in' do
      user = User.create(:username => "test 123", :email => "test123@test.com", :password => "test")


      visit '/login'

      fill_in(:username, :with => "test 123")
      fill_in(:password, :with => "test")
      click_button 'submit'
      expect(page.current_path).to eq('/user/test-123')
    end
  end

