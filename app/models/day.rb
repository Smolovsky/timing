class Day < ActiveRecord::Base
  belongs_to :task
  has_many :session_of_timers

  def save_time(time, time_to_plan,date)
    self.time_to_plan = time_to_plan

    if self.save
      true
    end

    self.session_of_timers.create(start_time: date, time_in_work: time)
  end

  def get_formatted_sum_time_of_day
    total_time = self.session_of_timers.sum(:time_in_work).to_i
    int_to_time(total_time)
  end

  def get_total_time_of_day
    total_time = self.session_of_timers.sum(:time_in_work).to_i
    total_time - get_int_from_date(self.time_to_plan)
  end

  def get_int_from_date date
    h = date.to_formatted_s(:only_hours).to_i
    m = date.to_formatted_s(:only_minutes).to_i
    s = date.to_formatted_s(:only_seconds).to_i

    h*3600+m*60+s
  end

  def int_to_time val
    h = val/3600
    m = (val-h*3600)/60
    s = val - h*3600 - m*60

    h='0'+h.to_s if h<10
    m='0'+m.to_s if m<10
    s='0'+s.to_s if s<10

    "#{h}:#{m}:#{s}"
  end

end
