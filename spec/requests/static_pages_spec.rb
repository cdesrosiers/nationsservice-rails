require 'spec_helper'

describe "Static pages" do

  describe "About page" do

    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      page.should have_content('About Us')
    end
    
    it "should have the right title" do
      visit '/static_pages/about'
      page.should have_selector('title', :text => "Nations' Service | About Us")
    end


  end
  
  describe "Contact page" do

    it "should have the content 'Contact'" do
      visit '/static_pages/contact'
      page.should have_content('Contact')
    end
    
    it "should have the right title" do
      visit '/static_pages/contact'
      page.should have_selector('title', :text => "Nations' Service | Contact")
    end
  end
  
  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_content('Help')
    end
    
    it "should have the right title" do
      visit '/static_pages/help'
      page.should have_selector('title', :text => "Nations' Service | Help")
    end
  end
end