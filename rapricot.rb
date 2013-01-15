class Rapricot
  def self.render(document)
    case document
    when Array
      render_element(document)
    else
      document.to_s
    end
  end

  def self.render_element(element)
    tag = element[0]
    optional_attributes = element[1]

    start_of_tag = "<#{tag}"
    end_of_tag = ">"
    closing_tag = "</#{tag}>"

    if optional_attributes.class == Hash
      attributes = optional_attributes.map do |key, value|
        " #{key}=\"#{value}\""
      end.join

      content = element[2..-1].map{|c| render(c) }.join
    else
      attributes = ""
      content = element[1..-1].map{|c| render(c) }.join
    end

    start_of_tag + attributes + end_of_tag + content + closing_tag
  end
end

