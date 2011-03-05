module ApplicationHelper
  def page_title
    # TODO: Use this in the head title - doesn't seem to work properly...
    (@content_for_title + " &mdash; " if @content_for_title).to_s + 'Storyboard'
  end

  def page_heading(text)
    content_for(:title, text)
  end
  
  def sub_heading(text)
    "<div class='subHeading'>#{text}</div>".html_safe
  end
end
