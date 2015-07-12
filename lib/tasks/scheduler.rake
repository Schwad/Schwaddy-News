require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

desc "This task is called by the Heroku scheduler add-on"


task :send_reminders => :environment do
  User.all.each do |user|
    puts "sending email..."
    user.send_test_email
    puts "done"
  end
end

task :tweet_porkcast => :environment do
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "WNnutRVMrGhBGBcnx7auBHTDv"
    config.consumer_secret     = "al4WR18nEXJBANQ1qSIMutblzHU105WlPdEhIPkbSvPvIj3Kum"
    config.access_token        = "20441925-beI6LAZ6SBe5q8qCxZjUMJV4uAPfy9ZE2pWLQuBDp"
    config.access_token_secret = "Pb1AYeKZaLikgNznLRIfr8zLpXecYel87eDuFNODx1Pik"
  end
  @payment = "AHHHHHHHHHFDJSKLAFJKLDAS;JFKLASD;JFKL;DASJKLF;AJSDKL;FJDASKL;FJKLADS;JFKL;DASJFKL;ADSJFKL;ASDJKLF;ADSJKLFJDSAL;FFDSJFKLSDJFKLDSJFLKJDSLKFJDSLKFJKLDSFJKLDSJFLKDSJFLKDSJLKFDJKLSDFJKLFJKLDFSJKLDSJFKLDSJFLKSD"

  while @payment.length > 140
    puts "Too long tweet, (length is #{@payment.length} retrying"
    @check = Check.all.sample
    @payee = []
    @check.payee.split(" ").each do |word|
      word = word[0] + word[1..-1].downcase
      @payee << word
    end
    @payee = @payee.join(" ")

    @payment = "Montana paid $#{sprintf("%.2f",@check.amount)} to #{@payee} on #{@check.payment_date.month}/#{@check.payment_date.day}/#{@check.payment_date.year} http://porkcast.herokuapp.com/static_pages/shared.#{@check.payee.gsub(" ", "%20")} #mtpol"
  end

  client.update("#{@payment}")

end

task :daily_api_check => :environment do
  # @start_time = Time.now
  puts "starting daily API check at #{Time.now}"
  # User.all.each do |user|
  #   puts 'Now querying for ' + user.email + '.....'
  #    user.queries.each do |query|
  #     if query.opt_out_email == false
  #       puts user.email + ' checking for new payments to ' + query.content + '.....'
  #       checks_checks(query)
  #       checks_credit_cards(query)
  #     end
  #   end
  # end
end

task :first_email_update => :environment do
  @users = User.all
  @users.each do |user|
  # email = "nicholas.schwaderer@gmail.com"
    UserMailer.admin_test(user).deliver!
  end
end