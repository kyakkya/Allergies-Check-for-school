class AttendancesController < ApplicationController
  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"

 def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    # 出勤時間が未登録であることを判定します。
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "給食の時間です！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
 end


 def lunch_check #アレルギーチェック
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    @superiors = User.where(superior: true).where.not(id: @user.id)
 end
 
 def update_lunch_check
   
   #アレルギーチェックのアップデート
    @user = User.find(params[:user_id])
　  @attendance = Attendance.find(params[:id])
  if params[:attendance][:first_teacher] == false || params[:attendance][:second_teacher] == false || params[:attendance][:student] == false
     flash[:danger] = "#{@user.name}さん,チェックをすべてしてください。 "
  elsif params[:attendance][:superior].blank? 
        flash[:danger] = "#{@user.name}さんが報告する担当を選択して下さい。 "
  else  
     # 更新失敗時の処理
     params[:attendance][:status] = "報告中"
     @attendance.update_attributes(lunch_check_params)
     flash[:success] = "#{@user.name}さんがアレルギーチェックをしました。"
     
  end 
    redirect_to user_url(@user)   
 end

 private
  def lunch_check__params
    params.require(:attendance).permit(:first_teacher, :second_teacher, :student, :superior, :status, :note)  
  end 

end  
