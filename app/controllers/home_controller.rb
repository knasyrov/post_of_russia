require 'russianpost'

class HomeController < ApplicationController
  def info
    @tracking_number = params[:tracking_number]
    @history = RussianPost.new(@tracking_number).get_history
    Rails.logger.info @history.inspect
  end
end
