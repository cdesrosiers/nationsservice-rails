require 'spec_helper'

describe Institution do
  before { @institution = Institution.new(name: "University of Foobar", state: "FB") }
  
  subject { @institution }
  
  it { should respond_to(:name) }
  it { should respond_to(:state) }
  
  describe "campus association" do
    
    before { @institution.save }
    let!(:campus_A) { Factory.create(:campus, institution: @institution, name: "A Campus") }
    let!(:campus_B) { Factory.create(:campus, institution: @institution, name: "B Campus") }
    
    it "should have a list of campuses" do
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
end
