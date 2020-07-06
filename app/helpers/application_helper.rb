module ApplicationHelper
  def full_title(page_title = '')
    if page_title.empty?
      'Threadom'
    else
      'Threadom - ' + page_title
    end
  end
end
