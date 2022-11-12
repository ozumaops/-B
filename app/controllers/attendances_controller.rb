class AttendancesController < ApplicationController
  include AttendancesHelper
  before_action :set_user, only: [:edit_one_month, :update_one_month]
  before_action :logged_in_user, only: [:update, :edit_one_month, :log_page]
  before_action :admin_or_correct_user, only: [:update, :edit_one_month, :update_one_month]
  before_action :set_one_month, only: :edit_one_month
  before_action :set_superior, only: [:edit_one_month, :update_one_month, :edit_overwork, :update_overwork, :update_month_request]
  
  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"
  
  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "おはようございます！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if@attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
  end
  
  def edit_one_month
  end
  
  def update_one_month
    ActiveRecord::Base.transaction do
    if attendances_invalid?
      attendances_params.each do |id, item|
        attendance = Attendance.find(id)
        attendance.update_attributes!(item)
      end
    flash[:success] = "1ヶ月分の勤怠情報を更新しました。"
    redirect_to user_url(date: params[:date])
    else
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to attendances_edit_one_month_user_url(date: params[:date])
    end
  end
  
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to attendances_edit_one_month_user_url(date: params[:date])
  end
  
  
  
  def log_page
    if Attendance.where(one_month_approval_status: "承認").order(:user_id, :worked_on).group_by(&:user_id)
      if params["select_year(1i)"].nil?
        @first_day = Date.current.beginning_of_month
      else
        @first_day = Date.parse("#{params["select_year(1i)"]}/#{params["select_month(2i)"]}/1")
      end
      #@attendances = @user.attendances.where(worked_on: {}, attendance_change_check_status: "承認済").order(:user_id, :worked_on).group_by(&:user_id)
      #@first_day = Date.current.beginning_of_month
      @last_day = @first_day.end_of_month   
      #@attendances = @user.attendances.where(worked_on: @first_day..@last_day).where(attendance_change_check_status: "勤怠変更承認済").order(:worked_on)
      @attendances = @user.attendances.where(worked_on: @first_day..@last_day, attendance_change_status: "承認").order(:worked_on)
    end
  end
  
  private
  
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end
      
    def set_superior
      @superior = User.where(superior:true).where.not(id:current_user.id)
    end
    
    # 一か月分の勤怠情報を扱います
    def attendances_params
      params.require(:user).permit(attendances: [:restarted_at,
                                                 :refinished_at,
                                                 :next_day, :note,
                                                 :superior_attendance_change_confirmation,
                                                 :attendance_change_status])[:attendances]
    end
    
    def attendance_change_params
      params.require(:user).permit(attendances: [:change_check, :attendance_change_status])[:attendances]
    end
end