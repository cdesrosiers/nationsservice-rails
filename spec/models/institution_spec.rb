require 'spec_helper'

describe Institution do
  before { @institution = Institution.new(name: "University of Foobar", state: "FB") }
  
  subject { @institution }
  
  it { should respond_to(:name) }
  it { should respond_to(:state) }
  
  it { should respond_to(:users) }
  it { should respond_to(:positions) }
  it { should respond_to(:campuses) }
  
  describe "campus association" do
    
    before { @institution.save }
    let!(:campus_A) { Factory.create(:campus, institution: @institution, name: "A Campus") }
    let!(:campus_B) { Factory.create(:campus, institution: @institution, name: "B Campus") }
    
    it "should have a list of campuses in the correct order" do
      @institution.campuses.should == [campus_A, campus_B]
    end
    
    it "should destroy associated campuses" do
      campuses = @institution.campuses
      @institution.destroy
      campuses.each do |campus|
        Campus.find_by_id(campus.id).should be_nil
      end
    end
  end
  
  describe "users" do
    before do
      @user1 = FactoryGirl.create(:user, institution: @institution)
      @user2 = FactoryGirl.create(:user, institution: @institution)
    end
    
    its(:users) { should include(@user1) }
    its(:users) { should include(@user2) }
    its(:users) { should have(2).items }
    
    describe "affliated institutions" do
      subject { @user1 }
      
      its(:institution) { should == @institution }
    end
    
    describe "changing their affiliated institution" do
      before do
        @user = FactoryGirl.create(:user, institution: @institution)
        @institution2 = FactoryGirl.create(:institution)
        
        @user.institution = @institution2
        @user.save
      end
            
      its(:users) { should_not include(@user) }
      
      describe "to a new one" do
        subject { @institution2 }
        
        its(:users) { should include(@user) }
      end
      
      describe "to nothing" do
        before do
          @user.institution = @institution2
          @user.save
        end
        
        its(:users) { should_not include(@user) }
      end
    end
  end
  
  describe "positions" do
    before do
      @position1 = FactoryGirl.create(:position, institution: @institution)
      @position2 = FactoryGirl.create(:position, institution: @institution)
    end
    
    its(:positions) { should include(@position1) }
    its(:positions) { should include(@position2) }
    its(:positions) { should have(2).items }
  end
end
