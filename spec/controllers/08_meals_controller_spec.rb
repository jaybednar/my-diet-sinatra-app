require 'spec_helper'

describe 'new action' do
    context 'logged in' do
      it 'lets user view new meal form if logged in' do
        user = User.create(:username => "test 123", :email => "test123@test.com", :password => "testpassword")

        visit '/login'

        fill_in(:username, :with => "test 123")
        fill_in(:password, :with => "testpassword")
        click_button 'submit'
        visit '/meals/new'
        expect(page.status_code).to eq(200)
      end

      it 'lets user create a meal if they are logged in' do
        user = User.create(:username => "test 123", :email => "test123@test.com", :password => "testpassword")

        visit '/login'

        fill_in(:username, :with => "test 123")
        fill_in(:password, :with => "testpassword")
        click_button 'submit'

        visit '/meals/new'
        fill_in(:name, :with => "NewMeal1")
        select "Chicken Breast", :from => "foods_1_select"
        fill_in(:foods_1_servings, :with => 2)
        select "Jasmine Rice", :from => "foods_2_select"
        fill_in(:foods_2_servings, :with => 1)
        select "Avocado Oil", :from => "foods_3_select"
        fill_in(:foods_2_servings, :with => 1)
        click_button 'submit'

        user = User.find_by(:username => "test 123")
        meal = meal.find_by(:name => "NewMeal1")
        expect(meal).to be_instance_of(Meal)
        expect(page.status_code).to eq(200)
      end

      it 'does not let a user create a blank meal' do
        user = User.create(:username => "test 123", :email => "test123@test.com", :password => "testpassword")

        visit '/login'

        fill_in(:username, :with => "test 123")
        fill_in(:password, :with => "testpassword")
        click_button 'submit'

        visit '/meals/new'
        fill_in(:name, :with => "NewMeal1")
        select "Chicken Breast", :from => "foods_1_select"
        fill_in(:foods_1_servings, :with => 2)
        select "Jasmine Rice", :from => "foods_2_select"
        fill_in(:foods_2_servings, :with => 1)
        select "Avocado Oil", :from => "foods_3_select"
        fill_in(:foods_2_servings, :with => 1)
        click_button 'submit'

        expect(meal.find_by(:name => "")).to eq(nil)
        expect(page.current_path).to eq("/meals/new")
      end
    end

    context 'logged out' do
      it 'does not let user view new meal form if not logged in' do
        get '/meals/new'
        expect(last_response.location).to include("/login")
      end
    end
  end

  describe 'show action' do
    context 'logged in' do
      it 'displays a single meal' do

        user = User.create(:username => "test 123", :email => "test123@test.com", :password => "testpassword")
        food1 = Food.create(name: "99% Lean Ground Turkey", serving_size: "4 oz", protein: 27, carbs: 0, fat: 1)
        food2 = Food.create(name: "Tortilla", serving_size: "1 Tortilla", protein: 2, carbs: 13, fat: 1.5)
        meal = Meal.create(name: "NewMeal1")
        meal.calculate_macros 

        visit '/login'

        fill_in(:username, :with => "test 123")
        fill_in(:password, :with => "testpassword")
        click_button 'submit'

        visit "/meals/#{meal.id}"
        expect(page.status_code).to eq(200)
        expect(page.body).to include(meal.name)
      end
    end

    context 'logged out' do
      it 'does not let a user view a meal' do
        user = User.create(:username => "test 123", :email => "test123@test.com", :password => "testpassword")
        meal = Meal.create(name: "NewMeal1")
        get "/meals/#{meal.id}"
        expect(last_response.location).to include("/login")
      end
    end
  end