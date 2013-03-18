module ApplicationHelper
  
  def full_title(page_title)
    base_title = "zepoc"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def link_to_add_fields(name, f, association)
    #new_object = f.object.send(association).klass.new
    new_object = f.object.class.reflect_on_association(association).klass.new  #can handle has_one 'as well'
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_field", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def flash_ajax()
    response = ""
    flash.each do |key, value|
      response = response + content_tag(:div, value, class: "alert alert-#{key}")
    end
    flash.discard
    response
  end

end
