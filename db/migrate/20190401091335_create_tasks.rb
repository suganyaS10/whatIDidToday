class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
    	t.string :description, null: false
    	t.integer :creator_id
      t.timestamps
    end
  end
end
