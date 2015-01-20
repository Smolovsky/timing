class SessionOfTimer < ActiveRecord::Base
  belongs_to :day

  # public def add_session_of_timer(session_time)
  #   self.time_in_work = session_time.to_time(:utc)
  #   binding.pry
  #   if self.save
  #     true
  #   end
  # end

end
