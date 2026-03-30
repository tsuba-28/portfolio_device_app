# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#ゲストユーザーのプロフィール変更データ
guest_user = User.guest

guest_profile = guest_user.profile

guest_profile.update!(
  nickname: "ゲストアカウント", 
  bio: "本ポートフォリオアプリ「@dEvicE」をご覧いただき、ありがとうございます！\nこちらはアプリの機能を体験いただくためのゲストアカウントになります。\n\nUIの確認や、実際の投稿機能などをご自由にお試しください。\n（※他のユーザーへの影響を防ぐため、このアカウント自体の編集・退会はロックされています）"
)

categories = [
  { name: "Mouse",    name_ja: "マウス",       slug: "mouse",    position: 1 },
  { name: "Mousepad", name_ja: "マウスパッド",  slug: "mousepad", position: 2 },
  { name: "Keyboard", name_ja: "キーボード",    slug: "keyboard", position: 3 },
  { name: "Monitor",  name_ja: "モニター",      slug: "monitor",  position: 4 },
  { name: "Headset",  name_ja: "ヘッドセット",   slug: "headset",  position: 5 },
  { name: "Mic",      name_ja: "マイク",        slug: "mic",      position: 6 },
  { name: "Others",   name_ja: "その他",        slug: "others",   position: 7 }
]

categories.each do |attrs|
  category = Category.find_or_initialize_by(slug: attrs[:slug])
  category.update!(
    name:      attrs[:name],
    name_ja:   attrs[:name_ja],
    position:  attrs[:position]
  )
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

#デバイスのデータ
devices = [
  #マウス
  { category_slug: "mouse", name: "G Pro X Superlight 2",           brand_name: "Logicool",      slug: "logicool-g-pro-superlight-2" },
  { category_slug: "mouse", name: "G Pro X Superlight 2 Dex",       brand_name: "Logicool",      slug: "logicool-g-pro-superlight-2 dex" },
  { category_slug: "mouse", name: "G Pro X Superlight 2c",          brand_name: "Logicool",      slug: "logicool-g-pro-superlight-2c" },
  { category_slug: "mouse", name: "G Pro X 2 SUPERSTRIKE",          brand_name: "Logicool",      slug: "logicool-g-pro-x-2-superstrike" },
  { category_slug: "mouse", name: "MX Master 3S",                   brand_name: "Logicool",      slug: "logicool-mx-master-3s" },
  { category_slug: "mouse", name: "MX Master 4S",                   brand_name: "Logicool",      slug: "logicool-mx-master-4s" },
  { category_slug: "mouse", name: "Inca",                           brand_name: "LAMUZU",        slug: "lamuzu-inca" },
  { category_slug: "mouse", name: "Maya X",                         brand_name: "LAMUZU",        slug: "lamuzu-maya-x" },
  { category_slug: "mouse", name: "Atlantis Mini Champion Edition", brand_name: "LAMUZU",        slug: "lamuzu-atlantis-mini-champion-edition" },
  { category_slug: "mouse", name: "NP-01 S Ergo Wireless",          brand_name: "ZYGEN",         slug: "zygen-np-01-s-ergo-wireless" },
  { category_slug: "mouse", name: "NP-01 S V2 Wireless",            brand_name: "ZYGEN",         slug: "zygen-np-01-s-v2-wireless" },
  { category_slug: "mouse", name: "JV-X Size 2",                    brand_name: "Pulsar",        slug: "pulsar-jv-x-size-2" },
  { category_slug: "mouse", name: "X2 CrazyLight",                  brand_name: "Pulsar",        slug: "pulsar-x2-crazylight" },
  { category_slug: "mouse", name: "X2H CrazyLight",                 brand_name: "Pulsar",        slug: "pulsar-xsh-crazylight" },
  { category_slug: "mouse", name: "Viper V3 Pro",                   brand_name: "Razer",         slug: "razer-viper-v3-pro" },
  { category_slug: "mouse", name: "Viper Mini Signature Edition",   brand_name: "Razer",         slug: "razer-viper-mini-signature-edition" },
  { category_slug: "mouse", name: "DeathAdder V3 Pro",              brand_name: "Razer",         slug: "razer-deathadder-v3-pro" },

  #マウスパッド
  { category_slug: "mousepad", name: "叢雲",                    brand_name: "AIM1",            slug: "aim1-murakumo" },
  { category_slug: "mousepad", name: "陽炎(Black)",             brand_name: "AIM1",            slug: "aim1-kagerou-black" },
  { category_slug: "mousepad", name: "NINJA FX 99式 (Xsoft)",   brand_name: "Artisan",         slug: "artisan-ninja-fx-99shiki-xsoft" },
  { category_slug: "mousepad", name: "NINJA FX 99式 (Soft)",    brand_name: "Artisan",         slug: "artisan-ninja-fx-99shiki-soft" },
  { category_slug: "mousepad", name: "NINJA FX 99式 (Mid)",     brand_name: "Artisan",         slug: "artisan-ninja-fx-99shiki-mid" },
  { category_slug: "mousepad", name: "NINJA FX ライデン (Xsoft)", brand_name: "Artisan",        slug: "artisan-ninja-fx-raiden-xsoft" },
  { category_slug: "mousepad", name: "NINJA FX ライデン (Soft)",  brand_name: "Artisan",        slug: "artisan-ninja-fx-raiden-soft" },
  { category_slug: "mousepad", name: "NINJA FX ライデン (Mid)",   brand_name: "Artisan",        slug: "artisan-ninja-fx-raiden-mid" },
  { category_slug: "mousepad", name: "NINJA FX ヒエン (Xsoft)",  brand_name: "Artisan",         slug: "artisan-ninja-fx-hien-xsoft" },
  { category_slug: "mousepad", name: "NINJA FX ヒエン (Soft)",   brand_name: "Artisan",         slug: "artisan-ninja-fx-hien-soft" },
  { category_slug: "mousepad", name: "NINJA FX ヒエン (Mid)",    brand_name: "Artisan",         slug: "artisan-ninja-fx-hien-mid" },
  { category_slug: "mousepad", name: "NINJA FX ゼロ (Xsoft)",    brand_name: "Artisan",         slug: "artisan-ninja-fx-zero-xsoft" },
  { category_slug: "mousepad", name: "NINJA FX ゼロ (Soft)",     brand_name: "Artisan",         slug: "artisan-ninja-fx-zero-soft" },
  { category_slug: "mousepad", name: "NINJA FX ゼロ (Mid)",      brand_name: "Artisan",         slug: "artisan-ninja-fx-zero-mid" },
  { category_slug: "mousepad", name: "EM-B Plus",               brand_name: "Endgame Gere",    slug: "endgamegere-em-b-plus" },
  { category_slug: "mousepad", name: "EM-C Plus",               brand_name: "Endgame Gere",    slug: "endgamegere-em-c-plus" },
  { category_slug: "mousepad", name: "ParaSpeed V2",            brand_name: "Pulsar",          slug: "pulsar-paraspeed-v2" },
  { category_slug: "mousepad", name: "ParaGlide",               brand_name: "Pulsar",          slug: "pulsar-paraglide" },
  { category_slug: "mousepad", name: "ES2 Black (3mm Soft)",    brand_name: "Pulsar",          slug: "pulsar-es2-black-3mm-soft" },
  { category_slug: "mousepad", name: "ES1 Black (3mm Soft)",    brand_name: "Pulsar",          slug: "pulsar-es1-black-3mm-soft" },
  { category_slug: "mousepad", name: "VA-005",                  brand_name: "WALLHACK",        slug: "wallhack-va-005" },
  { category_slug: "mousepad", name: "CR-005",                  brand_name: "WALLHACK",        slug: "wallhack-cr-005" },
  { category_slug: "mousepad", name: "SP-004",                  brand_name: "WALLHACK",        slug: "wallhack-sp-004" },

  #キーボード
  { category_slug: "keyboard", name: "80 HE",                  brand_name: "Wooting",         slug: "wooting-80-he" },
  { category_slug: "keyboard", name: "60 HE v2",               brand_name: "Wooting",         slug: "wooting-60-he-v2" },
  { category_slug: "keyboard", name: "PCMK 3 HE 60",           brand_name: "Pulsar",          slug: "pulsar-pcmk-3-he-60" },
  { category_slug: "keyboard", name: "PCMK 3 HE TKL",          brand_name: "Pulsar",          slug: "pulsar-pcmk-3-he-tkl" },
  { category_slug: "keyboard", name: "A75 Master",             brand_name: "DrunkDeer",       slug: "drunkdeer-a75-master" },
  { category_slug: "keyboard", name: "A75 Ultra",              brand_name: "DrunkDeer",       slug: "drunkdeer-a75-ultra" },
  { category_slug: "keyboard", name: "Apex Pro TKL",           brand_name: "SteelSeries",     slug: "steelseries-apex-pro-tkl" },
  { category_slug: "keyboard", name: "HHKB Professional HYBRID Type-S", brand_name: "PFU",    slug: "pfu-hhkb-professional-hybrid-type-s" },
  { category_slug: "keyboard", name: "Keychron Q1 pro",                 brand_name: "Keychron", slug: "keychron-keychron-q1-pro" },
  { category_slug: "keyboard", name: "ZENAIM KEYBOARD TKL",             brand_name: "ZENAIM",   slug: "zenaim-zenaim-keyboard-tkl" },

  #モニター
  { category_slug: "monitor", name: "ZOWIE XL2566K (360Hz)",          brand_name: "BenQ",      slug: "zowie-xl2566k" },
  { category_slug: "monitor", name: "LG UltraGear 27GR95QE-B (OLED)", brand_name: "LG",        slug: "lg-ultragear-27gr95qe-b" },
  { category_slug: "monitor", name: "Dell AW3423DW (OLED)",           brand_name: "Alienware", slug: "alienware-aw3423dw" },
  { category_slug: "monitor", name: "Dell U2723QE (4K)",              brand_name: "Dell",      slug: "dell-u2723qe" },
  { category_slug: "monitor", name: "ASUS ROG Swift Pro PG248QP (540Hz)", brand_name: "ASUS",  slug: "asus-rog-swift-pro-pg248qp" },

  #ヘッドセット
  { category_slug: "headset", name: "Logicool G PRO X 2 LIGHTSPEED",      brand_name: "Logicool G",      slug: "logicool-g-pro-x-2-lightspeed" },
  { category_slug: "headset", name: "HyperX Cloud III Wireless",          brand_name: "HyperX",          slug: "hyperx-cloud-iii-wireless" },
  { category_slug: "headset", name: "Razer BlackShark V2 Pro",            brand_name: "Razer",           slug: "razer-blackshark-v2-pro" },
  { category_slug: "headset", name: "SteelSeries Arctis Nova Pro Wireless", brand_name: "SteelSeries",   slug: "steelseries-arctis-nova-pro-wireless" },
  { category_slug: "headset", name: "EPOS H6PRO", brand_name: "EPOS", slug: "epos-h6pro" },

  #マイク
  { category_slug: "mic", name: "Shure SM7B",           brand_name: "Shure",       slug: "shure-sm7b" },
  { category_slug: "mic", name: "HyperX QuadCast S",    brand_name: "HyperX",      slug: "hyperx-quadcast-s" },
  { category_slug: "mic", name: "Elgato Wave:3",        brand_name: "Elgato",      slug: "elgato-wave-3" },
  { category_slug: "mic", name: "Blue Yeti",            brand_name: "Logicool For Creators", slug: "blue-yeti" },
  { category_slug: "mic", name: "Audio-Technica AT2020", brand_name: "Audio-Technica", slug: "audio-technica-at2020" },

  #その他
  { category_slug: "others", name: "Stream Deck",            brand_name: "ELGATO",         slug: "elgato-stream-deck" },
  { category_slug: "others", name: "Stream Deck +",          brand_name: "ELGATO",         slug: "elgato-stream-deck-plus" },
  { category_slug: "others", name: "AG03 MK2 W",             brand_name: "YAMAHA",         slug: "yamaha-ag03-mk2-w" },
  { category_slug: "others", name: "AG06 MK2 W",             brand_name: "YAMAHA",         slug: "yamaha-ag06-mk2-w" },
  { category_slug: "others", name: "ZG01",                   brand_name: "YAMAHA",         slug: "yamaha-zg01" },
  { category_slug: "others", name: "ZG02",                   brand_name: "YAMAHA",         slug: "yamaha-zg02" },
  { category_slug: "others", name: "BRIGE CAST",             brand_name: "Roland",         slug: "roland-brige-cast" },
  { category_slug: "others", name: "AT-UMX3 WH",             brand_name: "Audio Technica", slug: "audio-technica-at-umx3-wh" }
]

devices.each do |attrs|
  category = Category.find_by(slug: attrs[:category_slug])

  if category
    Device.find_or_create_by!(slug: attrs[:slug]) do |device|
      device.category_id = category.id
      device.name        = attrs[:name]
      device.brand_name  = attrs[:brand_name]
    end
  else
    puts "⚠️ 警告: カテゴリ '#{attrs[:category_slug]}' が見つからないため、'#{attrs[:name]}' はスキップされました。"
  end
end