module AttendancesHelper
  
  def attendance_state(attendance)
    # 受け取ったAttendanceオブジェクトが当日と一致するか評価します。
    if Date.current == attendance.worked_on
      return '出勤' if attendance.started_at.nil?
      return '退勤' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    # どちらにも当てはまらなかった場合はfalseを返します。
    return false
  end
  
  
  def working_times(start, finish)
    format("%.02f", (((finish - start) / 60) / 60))
  end
  
  def format_hour(time)
    format("%.02d", (time))
  end
      
  def format_min(time)
    format("%.02d", ((time / 15) * 15))
  end
  
   # 不正な値があるか確認する
  def attendances_invalid?
    attendances = true
    attendances_params.each do |id, item|
      if item[:started_at].blank? && item[:finished_at].blank?
        next
      elsif item[:started_at].blank? || item[:finished_at].blank?
        attendances = false
        break
      elsif item[:started_at] > item[:finished_at]
        attendances = false
        break
      end
    end
    return attendances
  end
end