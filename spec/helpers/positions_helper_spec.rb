require 'spec_helper'

describe PositionsHelper do

  describe "full_deadline" do    
    it "should include N/A for a nil deadline" do
      full_deadline(nil).should =~ /^Application deadline: N\/A/i
    end
    
    it "should include the full date for a valid deadline" do
      full_deadline(Date.today).should =~ /^Application deadline: [\w]+ [\d]+, [\d]+/i
    end
  end
  
  describe "full_position_type" do    
    it "should correctly display type: other" do
      full_position_type(0).should == 'Type: Other'
    end
    
    it "should correctly display a fellowship" do
      full_position_type(1).should == 'Type: Fellowship'
    end
    
    it "should correctly display an internship" do
      full_position_type(2).should == 'Type: Internship'
    end
    
    it "should correctly display a job" do
      full_position_type(3).should == 'Type: Job'
    end
    
    it "should correctly display when type is not available" do
      full_position_type(nil).should == 'Type: N/A'
    end
  end
  
  describe "full_description" do
    let(:position) { FactoryGirl.create(:position) }
    
    it "should show the position description" do
      full_description(position) { should == "Description: #{text}" }
    end
  end
end