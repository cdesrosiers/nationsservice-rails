require 'spec_helper'

describe Locale do
  
  before { @locale = FactoryGirl.create(:locale) }
  
  subject { @locale }
  
  it { should respond_to(:city) }
  it { should respond_to(:province) }
  it { should respond_to(:country) }
  it { should respond_to(:positions) }
  it { should respond_to(:placements) }
  
  describe "positions" do
    
    let(:position) { FactoryGirl.create(:position) }
    
    before do
      position.place_in!(@locale)
    end
    
    its(:positions){ should include(position) }
  end
  
end
