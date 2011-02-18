namespace :family_hut do

  desc "Notifies about new uploads"
  task :notify => :environment do
    locale_users = User.all.group_by(&:locale)
    photos = Photo.unnotified

    unless photos.empty?
      locale_users.each do |locale, users|
        I18n.locale = locale
        Notification.new_photos(users, photos).deliver
      end

      photos.each(&:notified!)
    end
  end

end