class MainController < ApplicationController
    layout "standard"

    def index

    end

    def register
        @user = User.new
    end

    def confirm_email

    end
end
