class UserMailer < ApplicationMailer
    #UserMailer.with(user: User.first).welcome_email.deliver_later
    def welcome_email
        @user = params[:user]
        @url  = 'http://example.com/login'
        mail(to: @user.email, subject: 'Welcome to the world of Trading!')
      end
    end
end
