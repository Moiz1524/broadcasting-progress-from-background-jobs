class HeavyTaskJob < ApplicationJob
  queue_as :default

  def perform
    total_count.times do |i|
      sleep rand
      Turbo::StreamsChannel.broadcast_replace_to(
        ["heavy_task_channel"],
        target: "heavy_task",
        partial: "heavy_tasks/progress",
        locals: {
          progress: (i + 1) * 100 / total_count
        }
      )
    end
  end

  def total_count
    @total_count ||= rand(10..100)
  end  
end
