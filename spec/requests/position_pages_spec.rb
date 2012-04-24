require 'spec_helper'

describe "Position pages" do
  
  subject { page }
  
  describe "edit" do
    
    let(:position) { FactoryGirl.create(:position) }
    let(:user) { FactoryGirl.create(:user) }
    
    
    before do
      sign_in user
      visit edit_position_path(position)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update this Position") }
      it { should have_selector('title', text: full_title("Edit Position")) }
      
      it { should have_selector('label', text: "Name") }
      it { should have_selector('input[@name="position[name]"]')}
      
      it { should have_selector('label', text: "Description") }
      it { should have_selector('input[@name="position[description]"]') }
      
      it { should have_selector('label', text: "Deadline") }
      it { should have_selector('input[@name="position[deadline]"]') }
      
      it { should have_selector('label', text: "Position type") }
      it { should have_selector('select[@name="position[position_type]"]')}
      
      it { should have_selector('label', text: "Duration") }
      it { should have_selector('select[@name="position[duration]"]')}
      
      it { should have_selector('label', text: "Institution") }
      it { should have_selector('select[@name="selected_institution[state]"]')}
      
      it { should have_selector('label', text: "Overview") }
      it { should have_selector('textarea[@name="position[overview]"]')}
    end

    describe "with invalid information" do
      before do
        select '',          from: 'Position type'
        click_button "Save Changes"
      end

      it { should have_content('error') }
    end
    
    describe "with valid information" do
      let(:new_name)  { "New Position Name" }
      before do
        fill_in "Name",               with: new_name
        select 'Fellowship',          from: 'Position type'
        click_button "Save Changes"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      specify { position.reload.position_type == 1 }
      specify { position.reload.name.should  == new_name }
    end
  end
  
  describe "index" do
    
    let(:position) { FactoryGirl.create(:position) }
    
    before do
      visit positions_path
    end
    
    it { should have_selector('title', text: full_title('All Positions')) }
    
    describe "pagination" do
      before(:all) { 31.times { FactoryGirl.create(:position) } }

      after(:all)  { Position.delete_all }

      it { should have_link('Next') }
      it { should have_link('2') }

      it "should list each position" do
        Position.find(:all, order: :name, limit: 3).each do |position|
          page.should have_selector('td', text: position.name)
        end
      end
    end
    
    describe "simple name search" do
      it { should have_selector('input[@name="search"]') }
      it { should have_selector('input[@type="submit"][@value="Search"]') }
      
      describe "should filter the list according to a search term" do
        let(:search_term) { 'job' }
        
        before do
          @job1 = FactoryGirl.create(:job, name: "This is a #{search_term} for computer programmers")
          @job2 = FactoryGirl.create(:job, name: "This is an internship for computer programmers")
          
          fill_in 'search', with: search_term
          click_button 'Search'
        end
        
        it { should have_selector('a', href: position_path(@job1), text: @job1.name) }
        it { should_not have_selector('a', href: position_path(@job2), text: @job2.name) }
      end
    end
    
    describe "calendar view" do
      
      it { should have_selector('a', href: calview_path, text: 'Calendar View') }
      
      describe "page" do
        before do
          click_link 'Calendar View'
        end
        
        it { should have_selector('title', text: full_title('Calendar View')) }
        it { should have_selector('h1', text: 'Calendar View') }
        it { should have_selector('a', href: positions_path, text: 'List View') }
        
        it "should render deadlines on the correct day"
        it "should not try to render positions without deadlines"
          
      end
    end
  end
  
  describe "show" do
    let(:position) { FactoryGirl.create(:position) }
    before do
      visit position_path(position)
    end
    
    it { should have_selector('h2',    text: position.name) }
    it { should have_selector('title', text: full_title(position.name)) }
    it { should have_content(full_overview(position)) }
    it { should have_content(full_deadline(position.deadline)) }
    it { should have_content(full_position_type(position.position_type)) }
    it { should have_content(full_description(position)) }
    it { should have_xpath('//ul[@class="locale-list"]') }
    
    describe "should list all locales" do
      let(:locale) { FactoryGirl.create(:locale) }
      before do
        position.place_in!(locale)
        visit position_path(position)
      end  
      
      it { should have_xpath('//ul[@class="locale-list"]/li', count: position.locales.count) }
    end
  end
end
