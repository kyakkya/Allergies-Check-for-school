class AddSixthGradeToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :sixth_grade, :string
  end
end
