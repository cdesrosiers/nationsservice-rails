require 'spec_helper'

describe Locale do
  
  before { @locale = FactoryGirl.create(:locale) }
  
  subject { @locale }
  
  it { should respond_to(:city) }
  it { should respond_to(:province) }
  it { should respond_to(:country) }
  
  it { should respond_to(:positions) }
  it { should respond_to(:placements) }
  
  it { should be_valid }
  
  describe "positions" do
    
    let(:position) { FactoryGirl.create(:position) }
    
    before do
      position.place_in!(@locale)
    end
    
    its(:positions){ should include(position) }
  end
  
  describe "without country selected" do
    before { @locale.country = "" }
    
    it{ should_not be_valid }
  end
  
  describe "without city selected" do
    before { @locale.city = "" }
    
    it { should be_valid }
  end
  
  describe "in a country with provinces" do
    # factory generates this by default
    
    describe "without a province selected but with a city selected" do
      before { @locale.province = "" }
      
      it { should_not be_valid }
    end
    
    describe "with an invalid province selected" do
      before { @locale.province = 'VIC' }
      
      it { should_not be_valid }
    end
  end
  
  describe "in a country without provinces" do
    before do
      @locale.country = 'GB'
      @locale.province = ""
    end
    
    it { should be_valid }
    
    describe "with a province selected" do
      before { @locale.province = 'FP' }
      
      it { should_not be_valid }
    end
  end
end
