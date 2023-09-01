require 'rails_helper'

RSpec.describe Task, type: :model do
  before(:all) do
    @project = FactoryBot.create(:project)
    @created_by = User.create(full_name: 'Yonas Tesfu', email: 'test@gmail.com', password: 'password')
  end

  it 'Creates a record' do
    task = FactoryBot.create(:task, project_id: @project.id, created_by_id: @created_by.id)
    expect(described_class.count).to be > 0
  end
end
