class Task < ActiveRecord::Base
  has_many :tasks
  belongs_to :user

  #todo допилить суммирование даты
  def get_total_time(task)
    days = Day.where task_id: task.id

    total_time =0

    days.each do |d|
      total_time += d.get_total_time_of_day(d.id, d.time_to_plan)
    end

    h = total_time/3600
    m = (total_time-h*3600)/60
    s = total_time - h*3600 - m*60
    is_negative = total_time<0 ? true : false

    my_format_time(h, m, s,is_negative)
  end

  def get_today_time
    day = Day.find_by_date(Time.now.to_date)
    #binding.pry
    if day == [] or day.nil?
      '00:00:00'
    else
      day.get_formatted_sum_time_of_day(day.id)
    end
  end

  def abs(a)
    if a<0
      a*-1
    end
    a
  end

  def my_format_time(h, m, s, is_negative)
    h='0'+h.to_s if abs(h)<10
    m='0'+m.to_s if abs(m)<10
    s='0'+s.to_s if abs(s)<10

    sign ='+'
    sign ='-' if is_negative

    "#{sign} #{h}:#{m}:#{s}"
  end
end
