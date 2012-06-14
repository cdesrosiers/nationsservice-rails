# == Schema Information
#
# Table name: positions
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  description   :string(255)
#  deadline      :date
#  poster_id     :integer
#  position_type :integer(2)
#  duration      :integer(2)
#  overview      :string(2047)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'spec_helper'

describe Position do
  
  before { @position = FactoryGirl.create(:position) }
  
  subject { @position }
  
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:deadline) }
  it { should respond_to(:logo_path) }
  it { should respond_to(:position_type) }
  it { should respond_to(:locales) }
  it { should respond_to(:placements) }
  it { should respond_to(:overview) }
  
  it { should respond_to(:place_in!) }
  it { should respond_to(:placed_in?) }
  it { should respond_to(:remove_from!) }
  
  describe "overview that is too long" do
    before { @position.overview = "a"*1025 }
    it { should_not be_valid }
  end
  
  describe "overview that is an acceptable length" do
    before { @position.overview = "a"*1024 }
    it { should be_valid }
  end
  
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
