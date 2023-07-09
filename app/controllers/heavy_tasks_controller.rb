class HeavyTasksController < ApplicationController
  def index; end
  
  def create
    HeavyTaskJob.perform_later
  end
end
