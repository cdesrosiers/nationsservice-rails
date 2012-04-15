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
      it { should have_selector('title', text: "Edit Position") }
    end

    describe "with invalid information" do
      before do
        select '',          from: 'Position type'
        click_button "Save changes"
      end

      it { should have_content('error') }
    end
    
    describe "with valid information" do
      let(:new_name)  { "New Position Name" }
      before do
        fill_in "Name",               with: new_name
        select 'Fellowship',          from: 'Position type'
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      specify { position.reload.position_type == 1 }
      specify { position.reload.name.should  == new_name }
    end
  end
  
  describe "index" do
    
    let(:position) { FactoryGirl.create(:position) }
    
    before { visit positions_path }
    
    it { should have_selector('title', text: 'All Positions') }
    
    describe "pagination" do
      before(:all) { 31.times { FactoryGirl.create(:position) } }
      after(:all)  { Position.delete_all }

      it { should have_link('Next') }
      it { should have_link('2') }

      it "should list each position" do
        Position.all[0..2].each do |position|
          page.should have_selector('td', text: position.name)
        end
      end
    end
  end
  
  describe "show" do
    let(:position) { FactoryGirl.create(:position) }
    before { visit position_path(position) }
    
    it { should have_selector('h2',    text: position.name) }
    it { should have_selector('title', text: position.name) }
  end
end