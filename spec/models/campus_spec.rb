require 'spec_helper'

describe Campus do
  before do
    @institution = FactoryGirl.create(:institution)
    @campus = FactoryGirl.create(:campus, institution: @institution)
  end
  
  subject { @campus }
  
  it { should respond_to(:name) }
  it { should respond_to(:institution_id) }
  
  it { should respond_to(:institution) }
  it { should respond_to(:users) }
  
  describe "without institution_id" do
    before { @campus.institution_id = nil }
    
    it { should_not be_valid }
  end
  
  describe "institution" do
    its(:institution) { should == @institution }
  end
  
  describe "users" do
    before do
      @institution = FactoryGirl.create(:institution)
      @campus = FactoryGirl.create(:campus, institution: @institution)
      @user = FactoryGirl.create(:user, institution: @institution, campus: @campus)
    end
    
    its(:users) { should include(@user) }
    its(:users) { should have(1).item }
  end  
end
