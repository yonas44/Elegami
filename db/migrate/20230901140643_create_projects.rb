class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.boolean :completed, default: false
      t.boolean :public, default: false
      t.datetime :start_date
      t.datetime :due_date

      t.timestamps
    end
  end
end
