class AddClassroomToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :classroom, :string
  end
end
