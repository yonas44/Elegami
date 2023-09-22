class CreateMilestones < ActiveRecord::Migration[7.0]
  def change
    create_table :milestones do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title
      t.string :status, default: 'Not-started'
      t.date :due_date

      t.timestamps
    end
  end
end
