require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'Creates a record' do
    FactoryBot.create(:project)
    expect(described_class.count).to be > 0
  end
end
