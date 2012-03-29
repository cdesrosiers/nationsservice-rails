require 'spec_helper'

describe "Static pages" do
  
  subject { page }
  
  describe "Home page" do
    
    before { visit root_path }
  
    it { page.should have_selector('h1', text: "Nations' Service") }
  
    it "should have the base title" do
      page.should have_selector('title',
                        text: "Nations' Service")
    end
  end



  describe "About page" do
    
    before { visit about_path }

    it "should have the content 'About Us'" do
      page.should have_content('About Us')
    end
    
    it "should have the right title" do
      page.should have_selector('title', :text => "Nations' Service | About Us")
    end


  end
  
  describe "Contact page" do
    
    before { visit contact_path }
 
    it "should have the content 'Contact'" do
      page.should have_content('Contact')
    end
    
    it "should have the right title" do
      page.should have_selector('title', :text => "Nations' Service | Contact")
    end
  end
  
  describe "Help page" do
    
    before { visit help_path }
    
    it "should have the content 'Help'" do
      page.should have_content('Help')
    end
    
    it "should have the right title" do
      page.should have_selector('title', :text => "Nations' Service | Help")
    end
  end
end