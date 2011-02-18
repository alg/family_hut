class Notification < ActionMailer::Base

  default_url_options[:host] = AppConfig['host']
  default :from => AppConfig['from']

  def new_photos(users, photos)
    @user_photos = photos.group_by { |p| p.album.owner }
    
    mail  :to       => users.map { |u| "#{u.name} <#{u.email}>" }.join(', '),
          :subject  => t('notification.new_photos.subject')
  end

end
