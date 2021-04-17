class AddFirstTeacherToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :first_teacher, :boolean, default: false
  end
end
