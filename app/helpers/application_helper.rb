module ApplicationHelper
  
  def full_title(page_title)
    base_title = "zepoc"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def logo
    logo = image_tag("logo2.png", alt: "Sample App", class: "round")
  end
  
end
