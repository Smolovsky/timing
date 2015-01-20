module TasksHelper
  #todo допилить суммирование даты
  def get_total_time(task)
    days = Day.where task_id: task.id
    #h=0; m=0; s=0

    is_negative=false
    sum =0

    days.each do |d|
      sum += d.get_total_time_of_day(d.id, d.time_to_plan)
      #h += sum[:h]; m += sum[:m]; s += sum[:s]
      #binding.pry
    end

    if sum<0 #or sum[:s]<0 or sum[:m]<0
      #h=abs(h); m=abs(m); s=abs(s)
      is_negative =true
      sum*=-1
    end

    date = Time.at(sum)#Time.at(h.hours+m.minutes+s.seconds)
    h = date.to_formatted_s(:only_hours).to_i
    m = date.to_formatted_s(:only_minutes).to_i
    s = date.to_formatted_s(:only_seconds).to_i

    my_format_time(h, m, s, is_negative)
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
