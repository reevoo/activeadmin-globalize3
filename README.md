# ActiveAdmin::Globalize3
Makes it easy to translate your resource fields.

## Installation

```ruby
gem "activeadmin-globalize3"
```
## Your model

```ruby
translates :title, :description do
  validates_presence_of :title
end
```
## Editor configuration

```ruby
index do
  # ...
  translation_status
  # ...
  default_actions
end

form do |f|
  # ...
  f.translated_inputs "Translated fields" do |t|
    t.input :title
    t.input :content
  end
  # ...
end
```

## Friendly ID

If you want to use Friendly ID together with Globalize3, please take a look
at the `activeadmin-seo` gem.
