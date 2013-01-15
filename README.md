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

## Credits

[the word]
[the inspiration]

[the word]: http://www.urbandictionary.com/define.php?term=rapricot&defid=6557448
[the inspiration]: https://github.com/weavejester/hiccup

