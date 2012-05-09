module ApplicationHelper
  
  def title 
  base_title="This is home page for"
  if@title.nil?
  base_title
  else
  "#{base_title} | #{@title}"
  end
  end
   
end
