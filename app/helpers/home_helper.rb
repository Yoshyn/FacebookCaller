module HomeHelper
  def hash_to_html key,value
    html = ""
    if key.is_a?(Hash)
      html << "<tr><th><i class='icon-arrow-right'></i></th>"
      html << "<td>"
      html << "<table class='table''>"
      key.each do |subkey, subvalue|
        html << hash_to_html(subkey, subvalue)
      end
      html << "</table></td></tr>"
    elsif value.is_a?(Hash)
      html << "<tr><th>#{key} <i class='icon-arrow-right'></i></th>"
      html << "<td>"
      html << "<table class='table''>"
      value.each do |subkey, subvalue|
        html << hash_to_html(subkey, subvalue)
      end
      html << "</table></td></tr>"
    elsif value.is_a?(Array)
      html << "<tr><th>#{key} <i class='icon-arrow-right'></i></th>"
      html << "<td>"
      html << "<table class='table''>"
      value.each do |v|
        html << array_to_html(v)
      end
      html << "</table></td></tr>"
    else
      html << "<tr><th>#{key}:</th><td> #{value}</td></tr>"
    end
    return html
  end

  def array_to_html(value)
    html = ""
    if value.is_a?(Hash)
      html << "<tr><td><table class='table''>"
      value.each do |subkey, subvalue|
        html << hash_to_html(subkey, subvalue)
      end
      html << "</table></td></tr>"
    elsif value.is_a?(Array)
      html << "<tr><td><table class='table''>"
      value.each do |v|
        html << array_to_html(v)
      end
      html << "</table></td></tr>"
    else
      html << "<tr><td> #{value}</td></tr>"
    end
    return html
  end

end
