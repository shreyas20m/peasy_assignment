class DailyRecordsController < ApplicationController

  def index
    @daily_records = DailyRecord.all
  end
end
