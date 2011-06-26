class Notification < ActionMailer::Base

  default_url_options[:host] = AppConfig['host']
  default :from => AppConfig['from']

  def news(users, photos, comments)
    @user_photos    = photos.group_by { |p| p.album.owner }
    @photo_comments = comments.group_by { |c| c.commentable }
    
    mail  :to       => users.map { |u| "#{u.name} <#{u.email}>" }.join(', '),
          :subject  => t('notification.news.subject')
  end

end
