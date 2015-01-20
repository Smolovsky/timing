class Day < ActiveRecord::Base
  belongs_to :task, touch: true
  has_many :session_of_timers

  def save_time(time, time_to_plan)
    self.time_to_plan = time_to_plan

    if self.save
      true
    end

    session_of_timers.create(date: Time.now.to_date, time_in_work: time.to_time, day_id: self.id)
  end

  def get_sum_time_of_day(day_id)
    total_time = get_sum_time day_id

    h = total_time.to_formatted_s(:only_hours).to_i
    m = total_time.to_formatted_s(:only_minutes).to_i
    s = total_time.to_formatted_s(:only_seconds).to_i

     if h<10
       h='0'+h.to_s
     end

     if m<10
       m='0'+m.to_s
     end

     if s<10
       s='0'+s.to_s
     end

     "#{h}:#{m}:#{s}"
  end

  def get_total_time_of_day(day_id, time_to_plan)
    total_time = get_sum_time day_id
    is_negative = false

    if total_time < time_to_plan
      total_time = time_to_plan - total_time
      is_negative = true
    else
      total_time = total_time - time_to_plan
    end
    #
    # h = total_time.to_formatted_s(:only_hours).to_i
    # m = total_time.to_formatted_s(:only_minutes).to_i
    # s = total_time.to_formatted_s(:only_seconds).to_i

    # if is_negative
    #   h *= -1
    # end

    #{h: h, m: m, s: s}
    total = total_time.to_i
    total *=-1 if is_negative

    total
  end

  def get_sum_time(day_id)
    intervals = SessionOfTimer.where(day_id: day_id)
    # h=0; m=0; s=0
    i=0;
    intervals.each do |interval|
      # h += interval.time_in_work.to_time.to_formatted_s(:only_hours).to_i
      # m += interval.time_in_work.to_time.to_formatted_s(:only_minutes).to_i
      # s += interval.time_in_work.to_time.to_formatted_s(:only_seconds).to_i
      i +=interval.time_in_work.to_i

    end

    Time.at i
    #{h: h, m: m, s: s}
    #Time.at(h.hours+m.minutes+s.seconds)
  end
end
