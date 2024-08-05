class UserMailer < ApplicationMailer
    #UserMailer.with(user: User.first).welcome_email.deliver_later
    def welcome_email(user, url)
        @user = user
        @url  = url
        mail(to: @user.email, subject: 'Welcome to the world of Trading!')
    end
    
    def pending_approval_email(user)
        @user = user
        mail(to: @user.email, subject: 'Your Account is Pending Approval')
    end

    def approval_email(user)
        @user = user
        mail(to: @user.email, subject: 'Your Account Has Been Approved')
    end

end
