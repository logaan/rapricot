class Rapricot
  def self.parse(document)
    case document
    when Array
      parse_element(document)
    else
      document.to_s
    end
  end

  def self.parse_element(element)
    tag = element[0]
    optional_attributes = element[1]

    start_of_tag = "<#{tag}"
    end_of_tag = ">"
    closing_tag = "</#{tag}>"

    if optional_attributes.class == Hash
      attributes = optional_attributes.map do |key, value|
        " #{key}=\"#{value}\""
      end.join

      content = element[2..-1].map{|c| parse(c) }.join
    else
      attributes = ""
      content = element[1..-1].map{|c| parse(c) }.join
    end

    start_of_tag + attributes + end_of_tag + content + closing_tag
  end
end

