class AddFifthGradeToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :fifth_grade, :string
  end
end
