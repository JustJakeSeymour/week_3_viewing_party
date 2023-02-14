require 'rails_helper'

RSpec.describe 'Landing Page' do
    before :each do 
        user1 = User.create(name: "User One", email: "user1@test.com", password: 'password123')
        user2 = User.create(name: "User Two", email: "user2@test.com", password: 'password123')
        visit '/'
    end 

    it 'has a header' do
        expect(page).to have_content('Viewing Party Lite')
    end

    it 'has links/buttons that link to correct pages' do 
        click_button "Create New User"
        
        expect(current_path).to eq(register_path) 
        
        visit '/'

        click_link "Home"
        expect(current_path).to eq(root_path)
    end 
end
