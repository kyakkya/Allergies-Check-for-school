class AddClassToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :class, :string
  end
end
