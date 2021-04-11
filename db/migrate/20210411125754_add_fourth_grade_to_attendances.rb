class AddFourthGradeToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :fourth_grade, :string
  end
end
