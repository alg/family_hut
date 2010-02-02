require File.join(File.dirname(__FILE__), '..', 'lib', 'acts_as_commentable')
ActionView::Base.send(:include, CommentHelper)