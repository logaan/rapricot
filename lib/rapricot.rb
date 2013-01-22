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
    VOID_ELEMENTS.include?(type)
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
    when Array  then map(&:rapricot).join
    else raise ArgumentError.new("First element in tag must be Symbol or Array")
    end
  end

  private

  def rapricot_standardised
    self[1].is_a?(Hash) ? self : self.insert(1, {})
  end
end

class String
  def rapricot
    self
  end
end

class Fixnum
  def rapricot
    self.to_s
  end
end

p ['div#navigation', "Click me!"].rapricot
# => <div id="navigation">Click me!</div>

