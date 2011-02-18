class Notification < ActionMailer::Base

  default_url_options[:host] = AppConfig['host']
  default :from => AppConfig['from']

  def new_photos(user, photos)
    @user_photos = photos.group_by { |p| p.album.owner }
    mail  :to       => user.email,
          :subject  => "New photos"
  end

end
