# rapricot

**rapricot** *verb:* When someone shoves an apricot in another person's mouth
without their consent.

I have an apricot for you. Templating is terrible. We manipulate structured
documents as strings. Strings have no structure. Partials, layouts, form
helpers, concatenation of output with a block's binding... all ludicrous
bullshit features. And you still have to know html. This isn't abstraction.

We can do much better. We should representing our markup as structured data. It
makes all the bullshit features dissapear. Layouts? It's just a function that
wraps up some data. Partials are just functions that we call to insert some
data into our data. Helpers will finally be natural to write, not a context
switch to an uncomfortable form of the same thing. And finally people will read
your view code and understand what the hell is going on.

Your editor will even have highlighting support.

## Example

```ruby
puts Rapricot.render(
  [:html,
    [:head,
      [:title, "Small animals"]],
    [:body,
      [:p, {class: "cute"},
        [:strong, "Kittens"], " and ", [:strong, "Ducks"]]]])
```

Will print (all on one line):

```html
<html>
  <head>
    <title>Small animals</title>
  </head>
  <body>
    <p class="cute">
      <strong>Kittens</strong> and <strong>Ducks</strong>
    </p>
  </body>
</html>
```

## In practice

```ruby
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
def default_layout(title, page)
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
    default_layout("#{user.name}'s page", [
      search_box(search_query),
      user_partial(user)]))
end
```

## Credits

1. [the word](http://www.urbandictionary.com/define.php?term=rapricot&defid=6557448)
2. [the inspiration](https://github.com/weavejester/hiccup)

