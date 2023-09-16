require 'rails_helper'

RSpec.describe Milestone, type: :model do
  before(:all) {
    @project = FactoryBot.create(:project)
  }
  it "can be created successfully" do
    FactoryBot.create(:milestone)
  end
end
