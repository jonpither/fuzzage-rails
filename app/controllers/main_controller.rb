class MainController < ApplicationController
    layout "standard"

    def index

    end

    def register
        if request.get?
            @user = User.new
        else
            @user = User.new(params[:user])

            if @user.save
                UserMailer::deliver_register(@user, confirmation_hash(@user.name))

                flash[:notice] = "Thank you for registering! We have sent a confirmation email to #{@user.email} with instructions on how to validate your account."
                redirect_to(:action => "index")
            end
        end
    end

    def confirm_email
        @users = User.find :all

        for user in @users
            # if the passed hash matches up with a User, confirm him, log him in, set proper flash[:notice], and stop looking
            if confirmation_hash(user.name) == params[:hash] and !user.email_confirmed
                user.update_attributes(:email_confirmed => true)
#                session[:user_id] = user.id
                flash[:notice] = "Thank you for validating your email."
                break
            end
        end

        redirect_to(:action => "index")
    end

    private

    def confirmation_hash(string)
        Digest::SHA1.hexdigest(string + "secret word")
    end

end
