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

puts Rapricot.parse(
  [:html,
    [:head,
      [:title, "Small animals"]],
    [:body,
      [:p, {class: "cute"},
        [:strong, "Kittens"], " and ", [:strong, "Ducks"]]]])

# Returns (except all on one line):

# <html>
#   <head>
#     <title>Small animals</title>
#   </head>
#   <body>
#     <p class="cute">
#       <strong>Kittens</strong> and <strong>Ducks</strong>
#     </p>
#   </body>
# </html>

