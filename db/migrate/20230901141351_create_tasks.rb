class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.references :created_by, foreign_key: { to_table: :users }, null: false
      t.references :assigned_to, foreign_key: { to_table: :users }, null: false
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
