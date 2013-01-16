class Rapricot
  def self.render(document)
    case document
      when Array then render_element(document)
      else document.to_s
    end
  end

  def self.render_element(element)
    tag        = element.shift.to_s
    attributes = render_attributes(element)
    content    = element.map{|c| render(c) + "\n" }.join

    wrap_in_tag(tag, attributes, content)
  end

  def self.wrap_in_tag(tag, attributes, content)
    "<" + tag + attributes + ">\n" +
      content.each_line.map{|l| "  " + l }.join +
    "</" + tag + ">"
  end

  def self.render_attributes(element)
    case element.first
    when Hash
      element.shift.map do |key, value|
        " #{key}=\"#{value}\""
      end.join
    else
      ""
    end
  end
end

