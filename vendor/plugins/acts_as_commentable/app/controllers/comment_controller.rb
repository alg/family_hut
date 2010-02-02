class CommentController < ActionController::Base

  def create
    comment                   = Comment.new(params[:comment])
    comment.commentable_id    = params[:id]
    comment.commentable_type  = params[:type]

    render :update do |page|
      if comment.save
        unless params[:parent_id].blank?
          comment.move_to_child_of(Comment.find(params[:parent_id]))
        end
        page.redirect_to :back
      else        
        page[comment.commentable.div_id].replace_html :partial => "new_comment", :locals => { :comment => comment, :parent_id => params[:parent_id] }
      end
    end

  end

end