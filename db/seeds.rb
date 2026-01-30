# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

categories = [
  { name: "Mouse",    slug: "mouse",    position: 1 },
  { name: "Mousepad", slug: "mousepad", position: 2 },
  { name: "Keyboard", slug: "keyboard", position: 3 },
  { name: "Monitor",  slug: "monitor",  position: 4 },
  { name: "Headset",  slug: "headset",  position: 5 },
  { name: "Mic",      slug: "mic",      position: 6 }
]

categories.each do |attrs|
  Category.find_or_create_by!(slug: attrs[:slug]) do |category|
    category.name     = attrs[:name]
    category.position = attrs[:position]
  end
end

styles = [
  { name: "ミニマル", slug: "minimal", position: 1 },
  { name: "ゲーミング", slug: "gaming", position: 2 },
  { name: "ナチュラル", slug: "natural", position: 3 },
  { name: "ワークスペース", slug: "workspace", position: 4 },
  { name: "クリエイター", slug: "creator", position: 5 }
]

styles.each do |attrs|
  Style.find_or_create_by!(slug: attrs[:slug]) do |style|
    style.name     = attrs[:name]
    style.position = attrs[:position]
  end
end

tags = [
  "Whiteデスク", "Blackデスク", "木目調", "Mac", "Windows", "かわいい", "かっこいい", "ウルトラワイド", "マルチモニター", "パステル", "モダン", "DIY"
]

tags.each do |tag_name|
  ActsAsTaggableOn::Tag.find_or_create_by(name: tag_name)
end