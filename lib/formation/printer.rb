class Formation::Printer
  
  def print(form)
    html = ''
    html << print_errors(form.errors)
    form.elements.each do |element|
      if element.field?
        html << print_field(element)
      else
        html << print_fieldset(element)
      end
    end
    html
  end
  
  def print_error(error)
    <<-HTML
      <p style="color: red">#{error}</p>
    HTML
  end
  
  def print_errors(errors)
    errors.map { |error| print_error error }.join("\n")
  end
  
  def print_field(field)
    <<-HTML
      <li>
        <label>#{field.label}</label>
        <input type="text" name="#{field.name}" value="#{field.value}">
      </li>
    HTML
  end
  
  def print_fieldset(fieldset)
    <<-HTML
      <fieldset>
        <legend>#{fieldset.legend}</legend>
        <ol>
          #{fieldset.fields.map { |f| print_field f }.join("\n")}
        </ol>
      </fieldset>
    HTML
  end
  
end