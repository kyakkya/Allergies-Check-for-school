class AddThirdGradeToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :third_grade, :string
  end
end
