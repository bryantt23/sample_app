class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, index: true

      t.timestamps null: false
    end
    
    # By including both the user_id and created_at columns as an array, 
    # we arrange for Rails to create a multiple key index, 
    # which means that Active Record uses both keys at the same time
    add_index :microposts, [:user_id, :created_at]
  end
end
