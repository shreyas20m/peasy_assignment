class DailyRecordJob
  include Sidekiq::Job
  require 'sidekiq-scheduler'
  sidekiq_options queue: "daily_record_job"

  def perform(*args)
    # Do something

    # running every start of day i.e 00:00:00
    # day before record will create
    puts "DailyRecordJob Started ...."
    t1 = (Time.now - 1.day).beginning_of_day
    t2 = t1.end_of_day
    user = User.where(created_at: (t1..t2) )
    daily_record = DailyRecord.new(
      male_count: REDIS.get("#{t1.strftime("%d-%m-%Y")}_male_count").to_i,
      female_count: REDIS.get("#{t1.strftime("%d-%m-%Y")}_female_count").to_i,
      # male_avg_age: user.gender_count('male').average(:age),
      # female_avg_age: user.gender_count('female').average(:age),
      date_string: t1.strftime("%d-%m-%Y")
      )
    daily_record.save
    puts "DailyRecordJob Completed."

  end
end
