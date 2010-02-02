module CommentHelper

  def comments(commentable, opts={})
    opts = { :new_comment => true }.merge(opts)

    out = "<div class=\"comments\">"
    out << "<div class=\"count\">#{commentable.comments.size} Yorum</div>"
    out << comment(commentable.comments.base, opts)

    if opts[:new_comment]
      out << "<div id=\"#{commentable.div_id}_container\">"
      out << "<div id=\"#{commentable.div_id}\" class=\"form\">#{new_comment(commentable)}</div>"
      out << "</div>"
    end

    out << render(:partial => "comment/reply_comment", :locals => { :div_id => commentable.div_id, :reply_function => commentable.reply_function })
  end

  def new_comment(commentable)
    render :partial => "comment/new_comment", :locals => { :comment => commentable.comments.build, :parent_id => nil }
  end

  def comment(comments, opts)
    unless comments.empty?
      avatar = comments.first.commentable.avatar
      reply_function = comments.first.commentable.reply_function
      out = "<ul>"
      comments.each do |c|
        out << "<li>"
        out << "<div class=\"avatar\">#{image_tag c.gravatar_url}</div>" if avatar
        out << "<div class=\"author\">#{c.website ? link_to(c.name, c.website, :target => "_blank", :rel => "external nofollow") : c.name}</div>"
        out << "<div class=\"date\">#{c.created_at}</div>"
        out << "<div class=\"content\">#{c.comment}</div>"
        if opts[:new_comment]
          out << "<div class=\"reply\">"
          out << "<div class=\"reply_link\">#{link_to_function("cevapla", "#{reply_function}(this, #{c.id})")}</div>"
          out << "</div>"
        end
        out << comment(c.children, opts) unless c.children.empty?
        out << "</li>"
      end
      out << "</ul>"
    else
      ""
    end
  end

end