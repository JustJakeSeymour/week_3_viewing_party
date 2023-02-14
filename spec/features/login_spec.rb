require 'rails_helper'

RSpec.describe "User Log In" do
  it 'can log in a user with correct credentials' do
    user = User.create(name: 'User One', email: 'email@example.com', password: 'password123')

    visit "/"
    click_link "Log In"

    fill_in :email, with:'email@example.com'
    fill_in :password, with: 'password123'
    click_button 'Log In'
    
    expect(current_path).to eq("/users/#{user.id}")
    expect(page).to have_content("User One's Dashboard")
  end 
  
  it 'does not log in user with incorrect credentials' do 
    user = User.create(name: 'User One', email: 'email@example.com', password: 'password123')
    
    visit "/"
    
    click_link "Log In"
    
    fill_in :email, with:'email@example.com'
    fill_in :password, with: 'nottherightpassword'
    click_button 'Log In'
    
    
    expect(current_path).to eq("/login")
    expect(page).to have_content("Bad Credentials, try again.")
    
  end
  
  describe "User Log Out" do
    before :each do
      @user = User.create(name: 'User One', email: 'email@example.com', password: 'password123')
    
      visit "/"
      click_link "Log In"
    
      fill_in :email, with:'email@example.com'
      fill_in :password, with: 'password123'
      click_button 'Log In'
    end

    it 'does not display create user or log in link if user is logged in' do
      visit "/"
      
      expect(page).to_not have_link("Log In")
      expect(page).to_not have_button("Create New User")
      expect(page).to have_link("Log Out")
    end
    
    it 'can log a user out when link is clicked' do
      visit "/"
      
      click_link "Log Out"
      
      expect(current_path).to eq "/"

      expect(page).to have_link("Log In")
      expect(page).to have_button("Create New User")
    end
  end
end
