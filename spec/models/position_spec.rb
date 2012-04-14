require 'spec_helper'

describe Position do
  
  before { @position = FactoryGirl.create(:position) }
  
  subject { @position }
  
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:location_city) }
  it { should respond_to(:location_state) }
  it { should respond_to(:location_country) }
  it { should respond_to(:deadline) }
  it { should respond_to(:logo_path) }
  it { should respond_to(:position_type) }
  it { should respond_to(:locales) }
  it { should respond_to(:placements) }
  
  it { should respond_to(:place_in!) }
  it { should respond_to(:placed_in?) }
  it { should respond_to(:remove_from!) }
  
  describe "placement" do
    let(:locale) { FactoryGirl.create(:locale) }    
    before do
      @position.place_in!(locale)
    end

    it { should be_placed_in(locale) }
    its(:locales) { should include(locale) }
    
    describe "and removal" do
      before { @position.remove_from!(locale) }

      it { should_not be_placed_in(locale) }
      its(:locales) { should_not include(locale) }
    end
  end
  
end
