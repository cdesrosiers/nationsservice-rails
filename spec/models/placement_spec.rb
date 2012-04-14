require 'spec_helper'

describe Placement do
  
  let(:position) { FactoryGirl.create(:position) }
  let(:locale) { FactoryGirl.create(:locale) }
  let(:placement) do
    position.placements.build(locale_id: locale.id)
  end
  
  subject { placement }
  
  it { should be_valid }
  
  it { should respond_to(:locale_id) }
  it { should respond_to(:position_id) }
  it { should respond_to(:locale) }
  it { should respond_to(:position) }
  its(:locale) { should == locale }
  its(:position) { should == position }
  
  describe "accessible attributes" do
    it "should not allow access to position_id" do
      expect do
        Placement.new(position_id: position.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  
  describe "when locale id is not present" do
    before { placement.locale_id = nil }
    it { should_not be_valid }
  end

  describe "when position id is not present" do
    before { placement.position_id = nil }
    it { should_not be_valid }
  end
end
