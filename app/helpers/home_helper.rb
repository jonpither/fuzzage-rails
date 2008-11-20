module HomeHelper
    def open_seasons
        Season.find(:all, :conditions => {:status => 'open'})
    end
end
