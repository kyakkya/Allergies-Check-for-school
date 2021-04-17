class AddSecondTeacherToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :second_teacher, :boolean, default: false
  end
end
