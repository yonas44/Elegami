require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  before(:all) do
    FactoryBot.create(:project, title: 'first')
  end

  describe 'GET /index' do
    it 'returns all projects and render index.html' do
      get projects_path
      expect(response.body).to include('first')
    end
  end

  describe 'POST /create' do
    it 'creates a record and returns a flash' do
      post projects_path, params: { project: { title: 'second', description: 'second project' } }
      expect(response.body).to include('first')
    end
  end
end
