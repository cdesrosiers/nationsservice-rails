# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  gradyear        :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#

require 'spec_helper'

describe User do

  before do
    @institution = Institution.create!(name: "University of Foobar", state: "Foobar")
    @campus = @institution.campuses.create!(name: "East Campus")
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
    @user.institution = @institution
    @user.campus = @campus
  end
  
  subject { @user }
  
  # attributes
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:institution_id) }
  it { should respond_to(:campus_id) }
  it { should respond_to(:gradyear) }
  
  # methods
  it { should respond_to(:authenticate) }
  it { should respond_to(:institution) }
  it { should respond_to(:campus) }
  it { should respond_to(:posted_positions) }
  it { should be_valid }
  it { should_not be_admin }
  
  describe "with admin attribute set to 'true'" do
    before { @user.toggle!(:admin) }

    it { should be_admin }
  end
  
  describe "when name is not present" do
    before { @user.name = " "}
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email = " "}
    it { should_not be_valid }
  end
  
  describe "when password is not present" do
    
    describe "and should be" do
      before do
        @user.updating_password = true
        @user.password = @user.password_confirmation = " "
      end
      
      it { should_not be_valid }
    end
    
    it { should be_valid }
  end
  
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "with a password that is too short" do
    before { @user.password = "a" * 5 }
    it { should_not be_valid }
  end
  
  describe "when email format is valid" do
    invalid_addresses =  %w[user@foo,com user_at_foo.org example.user@foo.]
    invalid_addresses.each do |invalid_address|
      before { @user.email = invalid_address }
      it { should_not be_valid }
    end
  end
  
  describe "when email format is valid" do
    valid_addresses = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    valid_addresses.each do |valid_address|
      before { @user.email = valid_address }
      it { should be_valid }
    end
  end
  
  describe "when email is already taken" do
    before do
      user_with_dup_email = @user.dup
      user_with_dup_email.email = @user.email.upcase
      user_with_dup_email.save
    end
    
    it { should_not be_valid }
  end
  
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }
    
    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end
    
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
  
  describe "with invalid graduation year" do
    before { @user.gradyear = User::GRADYEAR_LOWER - 1 }
    
    it { should_not be_valid }
  end
  
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
  
  describe "institution" do
    its(:institution) { should == @institution }
    its(:campus) { should == @campus }
    
    describe "when neither a campus nor an institution is specified" do
      before do
        @user.campus_id = nil
        @user.institution_id = nil
      end
      
      it { should be_valid }
    end
    
    describe "when a campus is not specified but an institution is" do
      before { @user.campus_id = nil }
      
      its(:campus) { should == nil }
      it { should be_valid }
    end
    
    describe "when a campus is not consistent with the institution" do
      before do
        @institution2 = FactoryGirl.create(:institution)
        @campus2 = FactoryGirl.create(:campus, institution: @institution2)
        @user.campus_id = @campus2.id
      end
      
      it { should_not be_valid }
    end
  end
  
  describe "posted positions" do
    before do
      @user.save
      fellowship = {name: "Fellowship", description: "This is a fellowship", position_type: 1}
      internship = {name: "Internship", description: "This is an internship", position_type: 2}
      
      @fellowship = @user.posted_positions.create!(fellowship)
      @internship = @user.posted_positions.create!(internship) 
    end
    
    its(:posted_positions) { should include(@fellowship) }
    its(:posted_positions) { should include(@internship) }
    its(:posted_positions) { should have(2).items }
  end
end
