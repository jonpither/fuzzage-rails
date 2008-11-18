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
                flash[:notice] = "Thank you for registering! We have sent a confirmation email to #{@user.email} with instructions on how to validate your account."
                redirect_to(:action => "index")
            end
        end
    end

    def confirm_email

    end
end
