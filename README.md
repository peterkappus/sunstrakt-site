# sunstrakt-site
Simple site for selling Sunstrakt pieces

# Generating the "items.toml" file

- Put whatever SVGs in the svg folder as you want
- Make sure you have a `static/img/thumbs` folder
- Install docker for SVG rendering
- Run `ruby gen.rb` to generate the thumbs and and the `data/items.toml` file.

# Paypal Buy Now button - how to:
1. Login and edit your button
2. copy the code and paste in a new document
3. (optional) replace target "_top" with "_blank" if desired
4. replace "\n" with " "
5. replace " with \\\\"
6. copy and paste into `gen.rb` within the description.
