require 'spec_helper'  

describe "Homepage" do 
	it 'loads the homepage' do 
		get '/' 
		expect(last_response.status).to eq(200) 
		expect(last_response.status).to eq("Welcome to My Diet App")
	end 
end 

