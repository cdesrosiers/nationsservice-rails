require 'spec_helper'

describe "Position pages" do
  
  subject { page }
  
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
    
    it { should have_selector('h1',    text: position.name) }
    it { should have_selector('title', text: position.name) }
  end
end
