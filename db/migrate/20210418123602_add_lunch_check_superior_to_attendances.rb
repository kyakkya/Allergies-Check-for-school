class AddLunchCheckSuperiorToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :lunch_check_superior, :string
  end
end
