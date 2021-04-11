class AddSecondGradeToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :second_grade, :string
  end
end
