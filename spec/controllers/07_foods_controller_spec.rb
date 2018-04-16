require 'spec_helper'

describe 'new action' do
    context 'logged in' do
      it 'lets user view new food form if logged in' do
        user = User.create(:username => "test 123", :email => "test123@test.com", :password => "testpassword")

        visit '/login'

        fill_in(:username, :with => "test 123")
        fill_in(:password, :with => "testpassword")
        click_button 'submit'
        visit '/foods/new'
        expect(page.status_code).to eq(200)
      end

      it 'lets user create a food if they are logged in' do
        user = User.create(:username => "test 123", :email => "test123@test.com", :password => "testpassword")

        visit '/login'

        fill_in(:username, :with => "test 123")
        fill_in(:password, :with => "testpassword")
        click_button 'submit'

        visit '/foods/new'
        fill_in(:name, :with => "99% Lean Ground Turkey")  
        fill_in(:serving_size, :with => "4 oz")  
        fill_in(:protein, :with => 27)
        fill_in(:carbs, :with => 0)
        fill_in(:fat, :with => 1)
        click_button 'submit'

        user = User.find_by(:username => "test 123")
        food = Food.find_by(:name => "99% Lean Ground Turkey")
        expect(food).to be_instance_of(Food)
        expect(page.status_code).to eq(200)
      end

      it 'does not let a user create a blank food' do
        user = User.create(:username => "test 123", :email => "test123@test.com", :password => "testpassword")

        visit '/login'

        fill_in(:username, :with => "test 123")
        fill_in(:password, :with => "testpassword")
        click_button 'submit'

        visit '/foods/new'
        fill_in(:name, :with => "99% Lean Ground Turkey")  
        fill_in(:serving_size, :with => "4 oz")  
        fill_in(:protein, :with => 27)
        fill_in(:carbs, :with => 0)
        fill_in(:fat, :with => 1)
        click_button 'submit'

        expect(Food.find_by(:name => "")).to eq(nil)
        expect(page.current_path).to eq("/foods/new")
      end
    end

    context 'logged out' do
      it 'does not let user view new food form if not logged in' do
        get '/foods/new'
        expect(last_response.location).to include("/login")
      end
    end
  end

  describe 'show action' do
    context 'logged in' do
      it 'displays a single food' do

        user = User.create(:username => "test 123", :email => "test123@test.com", :password => "testpassword")
        food = Food.create(name: "99% Lean Ground Turkey", serving_size: "4 oz", protein: 27, carbs: 0, fat: 1)

        visit '/login'

        fill_in(:username, :with => "test 123")
        fill_in(:password, :with => "testpassword")
        click_button 'submit'

        visit "/foods/#{food.id}"
        expect(page.status_code).to eq(200)
        expect(page.body).to include(food.name)
      end
    end

    context 'logged out' do
      it 'does not let a user view a Food' do
        user = User.create(:username => "test 123", :email => "test123@test.com", :password => "testpassword")
        food = Food.create(name: "99% Lean Ground Turkey", serving_size: "4 oz", protein: 27, carbs: 0, fat: 1)
        get "/foods/#{food.id}"
        expect(last_response.location).to include("/login")
      end
    end
  end

  # describe 'edit action' do
  #   context "logged in" do
  #     it 'lets a user view Food edit form if they are logged in' do
  #       user = User.create(:username => "test 123", :email => "test123@test.com", :password => "testpassword")
  #       food = Food.create(name: "99% Lean Ground Turkey", serving_size: "4 oz", protein: 27, carbs: 0, fat: 1)
  #       visit '/login'

  #       fill_in(:username, :with => "test 123")
  #       fill_in(:password, :with => "testpassword")
  #       click_button 'submit'
  #       visit '/foods/1/edit'
  #       expect(page.status_code).to eq(200)
  #       expect(page.body).to include(food.name)
  #     end

  #     it 'lets a user edit their own Food if they are logged in' do
  #       user = User.create(:username => "test 123", :email => "test123@test.com", :password => "testpassword")
  #       Food = Food.create(:content => "Fooding!", :user_id => 1)
  #       visit '/login'

  #       fill_in(:username, :with => "test 123")
  #       fill_in(:password, :with => "testpassword")
  #       click_button 'submit'
  #       visit '/foods/1/edit'

  #       fill_in(:content, :with => "i love Fooding")

  #       click_button 'submit'
  #       expect(Food.find_by(:content => "i love Fooding")).to be_instance_of(Food)
  #       expect(Food.find_by(:content => "Fooding!")).to eq(nil)
  #       expect(page.status_code).to eq(200)
  #     end

  #     it 'does not let a user edit a text with blank content' do
  #       user = User.create(:username => "test 123", :email => "test123@test.com", :password => "testpassword")
  #       Food = Food.create(:content => "Fooding!", :user_id => 1)
  #       visit '/login'

  #       fill_in(:username, :with => "test 123")
  #       fill_in(:password, :with => "testpassword")
  #       click_button 'submit'
  #       visit '/foods/1/edit'

  #       fill_in(:content, :with => "")

  #       click_button 'submit'
  #       expect(Food.find_by(:content => "i love Fooding")).to be(nil)
  #       expect(page.current_path).to eq("/foods/1/edit")
  #     end
  #   end

  #   context "logged out" do
  #     it 'does not load -- instead redirects to login' do
  #       get '/foods/1/edit'
  #       expect(last_response.location).to include("/login")
  #     end
  #   end
  # end

  # describe 'delete action' do
  #   context "logged in" do
  #     it 'lets a user delete their own Food if they are logged in' do
  #       user = User.create(:username => "test 123", :email => "test123@test.com", :password => "testpassword")
  #       Food = Food.create(:content => "Fooding!", :user_id => 1)
  #       visit '/login'

  #       fill_in(:username, :with => "test 123")
  #       fill_in(:password, :with => "testpassword")
  #       click_button 'submit'
  #       visit '/foods/1'
  #       click_button "Delete Food"
  #       expect(page.status_code).to eq(200)
  #       expect(Food.find_by(:content => "Fooding!")).to eq(nil)
  #     end

  #     it 'does not let a user delete a Food they did not create' do
  #       user1 = User.create(:username => "test 123", :email => "test123@test.com", :password => "testpassword")
  #       Food1 = Food.create(:content => "Fooding!", :user_id => user1.id)

  #       user2 = User.create(:username => "silverstallion", :email => "silver@aol.com", :password => "horses")
  #       Food2 = Food.create(:content => "look at this Food", :user_id => user2.id)

  #       visit '/login'

  #       fill_in(:username, :with => "test 123")
  #       fill_in(:password, :with => "testpassword")
  #       click_button 'submit'
  #       visit "/foods/#{food2.id}"
  #       click_button "Delete Food"
  #       expect(page.status_code).to eq(200)
  #       expect(Food.find_by(:content => "look at this Food")).to be_instance_of(Food)
  #       expect(page.current_path).to include('/foods')
  #     end
  #   end

  #   context "logged out" do
  #     it 'does not load let user delete a Food if not logged in' do
  #       Food = Food.create(:content => "Fooding!", :user_id => 1)
  #       visit '/foods/1'
  #       expect(page.current_path).to eq("/login")
  #     end
  #   end
  # end
# end 