class DailyRecord < ApplicationRecord
  before_save :calculate_avg

  def calculate_avg
    puts "Inside avg calculate callback"
    t = Time.parse(self.date_string)
    t1 = t.beginning_of_day
    t2 = t.end_of_day
    user = User.where(created_at: (t1..t2))
    if self.male_count_changed? 
      puts "MALE AVG COUNT UPDATING...."
      self.male_avg_age = user.gender_count('male').average(:age)
    end
    if self.female_count_changed?
      puts "FEMALE AVG COUNT UPDATING...."
      self.female_avg_age = user.gender_count('female').average(:age)
    end
  end
end