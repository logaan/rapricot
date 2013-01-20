class Tag
  VOID_ELEMENTS = %w[area base br col command embed hr img input keygen link
  meta param source track wbr]

  def initialize(array_form)
    @tag, @attributes, *@content = array_form
  end

  def render
    void? ? opening_tag : full_tag
  end

  private

  def full_tag
    opening_tag + content + closing_tag
  end
  
  def void?
    VOID_ELEMENTS.include?(@tag.to_s)
  end

  def opening_tag
    "<#{@tag}#{attributes}>"
  end

  def attributes
    @attributes.map { |k, v| " #{k}=\"#{v}\"" }.join
  end

  def content
    @content.map(&:rapricot).join
  end

  def closing_tag
    "</#{@tag}>"
  end
end

class Array
  def rapricot
    Tag.new(rapricot_standardised).render
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

