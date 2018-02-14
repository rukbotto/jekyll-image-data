# Jekyll Image Data

[![Build Status](https://travis-ci.org/rukbotto/jekyll-image-data.svg?branch=master)](https://travis-ci.org/rukbotto/jekyll-image-data)

Image data for Jekyll posts and pages. Crawls markdown files in search of image
data ("src" and "alt" attributes) and makes it available as a post/page
metadata attribute.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "jekyll-image-data"
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install jekyll-image-data
```

## Usage

Define your images using Markdown format, plain HTML or by including a
`.liquid` file:

```markdown
![Alt text](/image-url)

or

![Alt text][ref]
[ref]: /image-url
```

```html
<img src="http://placehold.it/800x600" alt="Image">
```

```liquid
{% include "image.liquid" %}
```

This plugin gets executed in the `:posts, :post_render` and `:pages,
:post_render` hooks. After execution, `post.data["images"]` or
`page.data["images"]` will hold `alt` and `src` data for all images inside
post/page:

```ruby
post.data["images"] = [
  { "alt" => "Alt text", "url" => "/media/images/800x600.png" },
  { "alt" => "Alt text", "url" => "/media/images/800x600.jpg" },
  { "alt" => "Alt text", "url" => "/media/images/800x600.gif" }
]
```

```liquid
{% for image in page.images %}
  <img alt="{{ image.alt }}" src="{{ image.url }}" >
{% endfor %}
```

## Development

After checking out the repo, run `script/setup` to install dependencies. Then,
run `rake spec` to run the tests. You can also run `script/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/rukbotto/jekyll-image-data.

## License

The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).
