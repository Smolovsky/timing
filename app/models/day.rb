class Day < ActiveRecord::Base
  belongs_to :task
  has_many :session_of_timers

  def save_time(time, time_to_plan,is_new_day)
    self.time_to_plan = time_to_plan

    if self.save
      true
    end

    date = Time.now
    date -= 1.day if is_new_day

    session_of_timers.create(date: date, time_in_work: time, day_id: self.id)
  end

  def get_formatted_sum_time_of_day(day_id)
    total_time = get_sum_time day_id

    h = total_time/3600
    m = (total_time-h*3600)/60
    s = total_time - h*3600 - m*60

    h='0'+h.to_s if h<10
    m='0'+m.to_s if m<10
    s='0'+s.to_s if s<10

    "#{h}:#{m}:#{s}"
  end

  def get_total_time_of_day(day_id, time_to_plan)
    total_time = get_sum_time day_id
    time_to_plan = get_int_from_date(time_to_plan)

    if total_time <= time_to_plan
      total_time = time_to_plan - total_time
    else
      total_time = total_time - time_to_plan
    end

    total_time
  end

  def get_sum_time(day_id)
    intervals = SessionOfTimer.where(day_id: day_id)
    i=0

    intervals.each do |interval|
      i +=interval.time_in_work
    end

    i
  end

  def get_int_from_date date
    h = date.to_formatted_s(:only_hours).to_i
    m = date.to_formatted_s(:only_minutes).to_i
    s = date.to_formatted_s(:only_seconds).to_i

    h*3600+m*60+s
  end
end
