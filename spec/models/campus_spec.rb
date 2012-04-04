require 'spec_helper'

describe Campus do
  before do
    @institution = FactoryGirl.create(:institution)
    @campus = FactoryGirl.create(:campus, institution: @institution)
  end
  
  subject { @campus }
  
  it { should respond_to(:name) }
  it { should respond_to(:institution_id) }
end
