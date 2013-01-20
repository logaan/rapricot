class Tag
  VOID_ELEMENTS = %w[area base br col command embed hr img input keygen link
  meta param source track wbr]

  def initialize(array_form)
    @tag, @attributes, *@content = array_form
  end

  def render
    void? ? opening_tag : opening_tag + content + closing_tag
  end
  
  def void?
    VOID_ELEMENTS.include?(@tag.to_s)
  end

  def opening_tag
    "<#{@tag}#{attributes}>"
  end

  def content
    "\n" +
    @content.map do |child|
      "  " + child.rapricot + "\n"
    end.join
  end

  def closing_tag
    "</#{@tag}>"
  end

  def attributes
    @attributes.map do |key, value|
      " #{key}=\"#{value}\""
    end.join
  end
end

class Array
  def rapricot
    Tag.new(rapricot_standardise(self)).render
  end

  private
    def rapricot_standardise(element)
      element[1].is_a?(Hash) ?
        element : element.insert(1, {})
    end
end

class String
  def rapricot
    self
  end
end

[:p, {class: "foo"}, "stuff", "things"].rapricot
