require 'rails_helper'

RSpec.describe Milestone, type: :model do
  before(:all) do
    @project = FactoryBot.create(:project)
  end
  it 'can be created successfully' do
    FactoryBot.create(:milestone)
  end
end
