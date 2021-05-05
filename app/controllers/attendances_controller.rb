class AttendancesController < ApplicationController
  require 'line/bot'#gem読み込み
  UPDATE_ERROR_MSG = "登録に失敗しました。やり直してください。"

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
    if params[:attendance][:first_teacher] == "0" || params[:attendance][:second_teacher] == "0" || params[:attendance][:student] == "0"
      flash[:danger] = "#{@user.name}さん,チェックをすべてしてください。 "
    elsif params[:attendance][:lunch_check_superior].blank? 
      flash[:danger] = "アレルギー担当者を選択して下さい。 "
    else  
       # 更新時の処理
      params[:attendance][:status] = "報告中"
      @attendance.update_attributes(lunch_check_params)
      flash[:success] = "#{@user.name}さんがアレルギーチェックをしました。"
    end 
    redirect_to user_url(@user)   
  end
 
  def lunch_check_info 
    @user = User.find(params[:user_id])
    @requesters = Attendance.where(lunch_check_superior: @user.name, status: "報告中").order(:user_id).group_by(&:user_id)
  end 
 
  def update_lunch_check_info
    @user = User.find(params[:user_id])
    ActiveRecord::Base.transaction do 
      lunch_check_info_params.each do |id, item|
        if item[:superior_checker] == "1"
          attendance = Attendance.find(id)
          attendance.update_attributes!(item)
          @info_sum = Attendance.where(status: "確認済").count
          @unapproval_info_sum = Attendance.where(status: "要再確認").count
          flash[:success] = "確認済#{@info_sum}件、要再確認#{@unapproval_info_sum}件"
          test
        end #if end 
      end #each end 
      redirect_to user_url(@user)
    end #Acctive do end    
 #def end
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
  end #def end require 'line/bot'
 
  def test
    message = {
        type: 'text',
        text: "アレルギーチェックが行われました" #送られた内容をそのまま返す
    } 
     
    client ||= Line::Bot::Client.new { |config|
      config.channel_secret = "9b4e4731db8a314b562712c3c8cf1c54"
      config.channel_token = "/LhqzVxk6YuA5655YZBg8/7yhymmMegyBkGyr1y6Y6+v6O0cg5DWy6JfXWtb9YDr7zSDnqqAdwIxLXdSACnwxcxvZOiCk561cIdccN9vjKlYRNt6wio/TVtctbkyzCOpLe6H3s0CuQdzGxe3FBVrQgdB04t89/1O/w1cDnyilFU="
    }
    # 応答メッセージを送る
    client.broadcast(message)
  end
  

private

  def lunch_check_params
    params.require(:attendance).permit(:first_teacher, :second_teacher, :student, :lunch_check_superior, :status, :note)  
  end 
  
  def lunch_check_info_params 
    params.require(:user).permit(attendances: [:status, :superior_checker])[:attendances]
  end  
  
  
end  
