namespace :family_hut do

  desc "Notifies about new uploads"
  task :notify => :environment do
    locale_users  = User.all.group_by(&:locale)
    photos        = Photo.unnotified
    comments      = Comment.unnotified

    unless photos.empty? && comments.empty?
      locale_users.each do |locale, users|
        I18n.locale = locale
        Notification.news(users, photos, comments).deliver
      end

      Photo.update_all({ :notified => true }, { :id => photos.map(&:id) })
      Comment.update_all({ :notified => true }, { :id => comments.map(&:id) })
    end
  end

end