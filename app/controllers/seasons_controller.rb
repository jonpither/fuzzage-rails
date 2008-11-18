class SeasonsController < ApplicationController
    layout "standard"
    
    def index
        @seasons = Season.find(:all)
    end

    def show
        @season = Season.find(params[:id])
    end

    def new
        @season = Season.new
    end

    def edit
        @season = Season.find(params[:id])
    end

    def create
        p "here #{params[:season]}"
        @season = Season.new(params[:season])
        if @season.save
            flash[:notice] = 'Season was successfully created.'
            redirect_to(@season)
        else
            render :action => "new"
        end
    end

    def update
        @season = Season.find(params[:id])

        if @season.update_attributes(params[:season])
            flash[:notice] = 'Season was successfully updated.'
            redirect_to(@season)
        else
            render :action => "edit" 
        end
    end

    def destroy
        @season = Season.find(params[:id])
        @season.destroy

        redirect_to(seasons_url) 
    end
end
