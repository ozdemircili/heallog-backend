require 'rails_helper'

RSpec.describe Istitution, :type => :model do
  it { should have_many(:doctors) }
end
