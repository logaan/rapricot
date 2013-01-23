class Element
  VOID_ELEMENTS = %w[area base br col command embed hr img input keygen link
  meta param source track wbr]

  def initialize(array_form)
    @type, @attributes, *@content = array_form
  end

  def render
    void? ? opening_tag : full_tag
  end

  private

  def full_tag
    opening_tag + content + closing_tag
  end

  def void?
    VOID_ELEMENTS.include?(type.to_s)
  end

  def type
    @type.to_s
  end

  def opening_tag
    "<#{type}#{attributes}>"
  end

  def attributes
    @attributes.map { |k, v| " #{k}=\"#{v}\"" }.join
  end

  def content
    @content.map(&:rapricot).join
  end

  def closing_tag
    "</#{type}>"
  end
end

class Array
  def rapricot
    case first
    when Symbol then Element.new(rapricot_standardised).render
    when String then Element.new(rapricot_standardised.split_attributes).render
    when Array  then map(&:rapricot).join
    end
  end

  protected

  def rapricot_standardised
    self[1].is_a?(Hash) ? self : self.insert(1, {})
  end

  def split_attributes
    splited_attr = split_string self[0]
    [splited_attr[1].to_s, attributes(self[1], splited_attr), self[2] ]
  end

  private

  def split_string attributes_string
    attributes_string.match /([^\.\#]*)(\#([^\.]*))?(\.(.*))?/
  end

  def attributes raw_attr, attr_from_string
    id = attr_from_string[3] && raw_attr["id"].nil? ? {"id" => attr_from_string[3]} : {}
    classes = attr_from_string[5] && raw_attr["class"].nil? ? {"class" => attr_from_string[5].gsub( /\./, ' ')} : {}
    raw_attr.merge(id).merge(classes)
  end
end

class String
  def rapricot
    self
  end
end

