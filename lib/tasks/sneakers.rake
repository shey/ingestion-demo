# lib/tasks/sneakers.rake
require 'sneakers/tasks'

namespace :sneakers do
  desc 'Run sneakers workers'
  task :run => :environment do
    # force Rails to autoload your workers
    Rails.application.eager_load!

    runner = Sneakers::Runner.new([AlertWorker])
    runner.run
  end
end
