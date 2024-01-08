class CreateUserJob
  include Sidekiq::Job
  require 'sidekiq-scheduler'
  sidekiq_options queue: "create_user_job"


  def perform(*args)
    # Do something
    puts "CreateUserJob Started ...."
    url = 'https://randomuser.me/api?results=20'
    response = Typhoeus::Request.get(url, timeout: 60)
    if response.code >= 200
      response_body = JSON.parse(response.body)
      response_body.dig('results').to_a.each do |data|
        user = User.find_or_initialize_by(uuid: data.dig('login', 'uuid'))
        user.update(
          gender: data.dig('gender'),
          name: data.dig('name'),
          location: data.dig('location'),
          age: data.dig('dob', 'age')
          )
      end
    else

      Puts "Invalid data from API"
    end
    puts "CreateUserJob Completed."

  end
end
