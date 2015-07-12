require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

desc "This task is called by the Heroku scheduler add-on"

task :update_page => :environment do
  puts "Updating whole page"a
  updates_page
end
