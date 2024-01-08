class User < ApplicationRecord
  after_commit :update_redis_count
  scope :gender_count, -> (gen) {where(gender: gen) }

  def update_redis_count
    REDIS.set('user_count', User.count)
    t = self.created_at
    t1 = t.beginning_of_day
    t2 = t.end_of_day
    REDIS.set("#{t.strftime("%d-%m-%Y")}_male_count", User.gender_count("male").where(created_at:(t1..t2)).count)
    
    REDIS.set("#{t.strftime("%d-%m-%Y")}_female_count", User.gender_count("female").where(created_at:(t1..t2)).count)

    # update DailyRecord if user deleting and daily record exists
    if destroyed?
      puts "YOU were destroying User record"
      daily_record = DailyRecord.find_by(date_string: t.strftime("%d-%m-%Y"))
      if daily_record
        puts "DailyRecord found and Updating"
        daily_record.update(
          male_count: REDIS.get("#{t1.strftime("%d-%m-%Y")}_male_count"),
          female_count: REDIS.get("#{t1.strftime("%d-%m-%Y")}_female_count")
          )
      end
    end
  end

  def full_name
    "#{name.dig('title').to_s} #{name.dig('first').to_s} #{name.dig('last').to_s}"
  end
end