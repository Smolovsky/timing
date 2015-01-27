class Task < ActiveRecord::Base
  has_many :days
  belongs_to :user

  #todo допилить суммирование даты
  def get_total_time
    total_time =0
    self.days.each do |d|
      total_time += d.get_total_time_of_day
    end

    is_negative = total_time<0 ? true : false
    total_time = abs total_time

    h = total_time/3600
    m = (total_time-h*3600)/60
    s = total_time - h*3600 - m*60

    my_format_time(h, m, s,is_negative)
  end

  def get_today_time
    # day = Day.find_by_date(Time.now.to_date)
    #
    # if day == [] or day.nil?
    #   '00:00:00'
    # else
    #
    # end
    self.days.last.get_formatted_sum_time_of_day
  end

  def abs(a)
    a<0? a*=-1 : a
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
