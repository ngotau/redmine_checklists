class CreateProjectChecklists < ActiveRecord::Migration
  def change
    create_table :project_checklists do |t|
      t.references :project, :null => false
      t.integer :tracker_id
      t.string :subject
      t.integer :position, :default => 1
      t.boolean :is_done, :default => false
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
