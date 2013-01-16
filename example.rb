require "./lib/rapricot"

# Form Helper
def text_field(name, value)
  [:input, {type: "text", name: name, value: value}]
end

# Partial
def user_partial(user)
  [:div, {class: "user"},
    [:span, {class: "name"}, user.name],
    [:br],
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
