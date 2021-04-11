class AddFirstGradeToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :first_grade, :string
  end
end
