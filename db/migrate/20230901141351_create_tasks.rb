class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :description, null: false
      t.string :priority, default: 'Low'
      t.references :milestone, null: false, foreign_key: true
      t.string :status, default: 'unassigned'

      t.timestamps
    end
  end
end
