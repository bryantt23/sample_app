class AddActivationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_digest, :string
    
    # default boolean value of false to the activated attribute
    add_column :users, :activated, :boolean, default: false
    
    add_column :users, :activated_at, :datetime
  end
end