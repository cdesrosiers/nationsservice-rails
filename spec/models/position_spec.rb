require 'spec_helper'

describe Position do
  
  before { @position = Position.new }
  
  subject { @position }
  
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:location_city) }
  it { should respond_to(:location_state) }
  it { should respond_to(:location_country) }
  it { should respond_to(:deadline) }
  it { should respond_to(:logo_path) }
  it { should respond_to(:position_type) }
  
end
