class Rapricot
  def self.render(document)
    case document
      when Array then render_element(document)
      else document.to_s
    end
  end

  def self.render_element(element)
    tag = element[0]
    optional_attributes = element[1]

    start_of_tag = "<#{tag}"
    end_of_tag = ">"
    closing_tag = "</#{tag}>"

    case optional_attributes
    when Hash
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

# Form Helper
def text_field(name, value)
  [:input, {type: "text", name: name, value: value}]
end

# Partial
def user_partial(user)
  [:div, {class: "user"},
    [:span, {class: "name"}, user.name],
    [:ul, {class: "friends"}].concat(user.friends.map do |friend|
      [:li, {class: "friend"}, friend.name]
    end)]
end

# Layout
def default_layout(title, *page)
  [:html,
    [:head,
      [:title, title]],
    [:body,
      [:div, {id: "container"}].concat(page)]]
end

# Complete view
def search_box(search_query)
  [:div, {class: "search"}, text_field("search_query", search_query)]
end

def user_page(user, search_query)
  Rapricot.render(
    default_layout("#{user.name}'s page",
      search_box(search_query),
      user_partial(user)))
end

# Model
class User
  attr_accessor :name, :friends

  def initialize(name, friends)
    @name = name
    @friends = friends
  end
end

# Data
andy  = User.new("Andy",  [])
kiril = User.new("Kiril", [])
logan = User.new("Logan", [andy, kiril])

puts user_page(logan, "log")
