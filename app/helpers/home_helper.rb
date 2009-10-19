module HomeHelper
    def open_seasons user
      seasons = Season.find(:all, :conditions => {:status => 'open'})
      seasons.find_all{|season| !user.playing_in?(season)}
    end
end
