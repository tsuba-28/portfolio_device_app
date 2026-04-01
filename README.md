# デバイス共有デスク紹介アプリ「＠dEvicE」

## はじめに

- 本リポジトリはWebアプリ「@dEvicE」に関するものです。
- ご利用いただくことによるトラブル等につきましては、一切の責任を負いかねますことを予めご了承ください。


## 🔗 アプリURL

[ ![App URL](https://img.shields.io/badge/Check%20the%20App-4182fa?style=for-the-badge&logo=rocket&logoColor=white) ](https://portfolio-device-app-device.onrender.com)


 **🚀 ゲストログイン機能について**
 ログイン画面の「ゲストログイン」ボタンより、会員登録不要でアプリ機能をワンクリックでお試しいただけます。
 ※面接官の方など、お急ぎの方はこちらをご利用ください。
> [!CAUTION]
> Renderの無料枠にて提供しているため起動時 30秒〜1分 ほど時間がかかる場合があります。
> アプリTOPページが表示されるまでしばしお待ちください。
 
---

## 💡 開発背景
自分のデスク環境を共有する際既存のSNSでは「デスクの写真」＋「使用デバイス」を**両立**して共有するにはハードルが高いと感じていました。
そこで、テンプレート式に選択することで容易に共有することができるようにと考えてアプリを開発しました。

同時にこのアプリ開発を通じて、CRUD実装からUI/UX設計・運用など、WEB開発のプロセスを一通り経験することも目的としています。

## 🛠️ 開発環境 / 使用技術

- **開発環境**
  - macOS
- **バックエンド**
  - Ruby 3.3.10
  - Ruby on Rails 8.0.4
  - 主な使用Gem: `devise` (認証), `acts_as_taggable_on` (タグ管理)

- **フロントエンド**
  - HTML / CSS (Tailwind CSS)
  - JavaScript (Hotwire: Turbo / Stimulus)
  - UIライブラリ: TomSelect

- **インフラ / DB**
  - **ホスティング**: Render
  - **データベース**: PostgreSQL (Neon)
  - **画像ストレージ**: Active Storage + AWS (S3 / IAM)


## ⚙️ 機能一覧

| No. | 機能 |
| :---: | :--- |
| 1 | 📝 ユーザー新規登録・削除機能 |
| 2 | 🔑 ログイン・ログアウト機能 |
| 3 | 🎫 ゲストログイン機能 |
| 4 | 🛠️ プロフィール作成・編集機能 |
| 5 | 💻 デスク環境投稿機能 (CRUD) | 
| 6 | 💡 スタイル設定機能 |
| 7 | 🏷️ タグ付け機能 |
| 8 | 🎮 デバイス紐付け機能 |
| 9 | 📖 デスク環境一覧・詳細表示機能 | 

## 📊 ER図

<img width="1341" height="806" alt="Untitled" src="https://github.com/user-attachments/assets/965ab86d-767b-4cb8-850a-82a7da2d1c48" />

[👉 dbdiagram.io で図を確認する](https://dbdiagram.io/d/69bf0f6ffb2db18e3bd3b561)

## 🌐 インフラ構成図

<img width="3748" height="1120" alt="Portfolio Web App Infrastructure Diagram" src="https://github.com/user-attachments/assets/3441d6f9-b49d-435b-b91d-57610fdb9233" />

## 🚀 機能紹介

### 1. 📝 ユーザー新規登録・削除機能

| 新規登録フロー |
| :---: |
| ![ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/ce7dfa23-7b2c-4747-9871-1060967f1411) |

- ユーザーID、メールアドレス、パスワードで新規登録を行います
- パスワードはハッシュ化後DBに保存されます
- マイページからプロフィール情報（公開情報）を、アカウント設定から登録情報の変更、アカウント削除を行うことができます  
  **※ゲストユーザーではイタズラ防止の観点から編集、削除機能をロックしております。**

| プロフィール情報変更フォーム | ユーザー情報変更フォーム |
| :---: | :---: |
| ![2026-04-018 59 53-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/7498b6fc-c534-4427-993a-de377cbfbbe5) | ![2026-04-019 00 06-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/48003f50-97d9-4d6a-8bbd-8750f34a099c) |

### 2. 🔑 ログイン・ログアウト機能

| ログインフロー| ログアウトフロー |
| :---: | :---: |
| ![ezgif com-video-to-gif-converter (1)](https://github.com/user-attachments/assets/d766d566-2702-4cb5-9c59-70103e87c887) | ![ezgif com-video-to-gif-converter (2)](https://github.com/user-attachments/assets/ed880658-c6cb-441e-9875-a24810560460) |

- 登録したユーザーID（大文字・小文字区別無し）、メールアドレスとパスワードにてログインできます。
- 認証には `gem devise` を利用しています。  
 **※セキュリティを考慮しログイン失敗時のエラーメッセージには詳細を記載していません。**

### 3. 🎫 ゲストログイン機能

| ゲストログインフロー |
| :---: |
| ![ezgif com-video-to-gif-converter (3)](https://github.com/user-attachments/assets/bf9d5cfe-4c27-4a6c-a0b6-cc7fca553984) |

- ユーザー登録することなく、アプリ機能をお試しいただくことができます。
- 事前に作成されたゲストユーザーアカウントにログインされ　**荒らし、イタズラ** 対策のため一部機能が制限されています。

**【実装コード（`app/models/user.rb`）】**
```ruby
class User < ApplicationRecord
  # アソシエーション設定
  has_one :profile, dependent: :destroy
  
  # ユーザーデータ保存直後にメソッドを実行
  after_create :create_default_profile 

  private

  # デフォルトのプロフィールを作成するメソッド
  def create_default_profile
    # usernameが空の場合は、メールアドレスの@より前をデフォルトのニックネームとして採用
    default_nickname = self.username.presence || self.email.split('@').first
    
    # 関連付けられたプロフィールを生成（失敗時は例外を発生させるよう ! を使用）
    create_profile!(nickname: default_nickname)
  end
end
```

> [!WARNING]
> ゲストユーザーにて投稿されたものは開発者の判断にて削除されることがあります。
> アプリの意図から著しく外れているものなどにご注意の上投稿してください。

### 4. 🛠️ プロフィール作成・編集機能

| プロフィール編集フロー |
| :---: |
| ![ezgif com-video-to-gif-converter (4)](https://github.com/user-attachments/assets/cc03b4e0-bfbd-48b0-9508-b81aebb57327) |

- アカウント登録後入力されたアカウント情報を元に自動で作成されます。
- ユーザーのプロフィールにまつわる下記を編集することができます。
  - プロフィール背景画像
  - アイコン画像
  - ユーザーネーム
  - 自己紹介文

### 5. 💻 デスク環境投稿機能 (CRUD)

| 新規投稿フロー |
| :---: |
| ![2-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/a1aee7fe-b15c-4dd4-af99-78f19b6065f8) |

| 編集フロー | 削除フロー |
| :---: | :---: |
| ![ezgif com-video-to-gif-converter (5)](https://github.com/user-attachments/assets/f0657578-834a-4df8-824a-ec78f2c3c475) | ![ezgif com-video-to-gif-converter (6)](https://github.com/user-attachments/assets/b21bed12-d047-4e06-8ada-8a7ee80fedd1) |

- 投稿物に関係する下記アクションを行うことができます。
  - デスク環境に関係する写真の添付(５枚)
  - スタイルの選択
  - タグの設定
  - タイトル、コメントの記述
  - デバイスの追加

- N+1問題への対策として `includes` を用いた事前読み込みを行なっています。

```ruby
# app/controllers/desk_setups_controller.rb

def index
  # N+1問題を回避するため、関連するテーブル（user, style, tags）を事前に一括取得
  @desk_setups = DeskSetup.includes(:user, :style, :tags)
                          .order(created_at: :desc)
  # ...
end

def show
  # ネストした関連付け（userのprofile）まで含めて、無駄なSQL発行を完全に防ぐ
  @desk_setup = DeskSetup.includes(:style, :devices, :base_tags, user: :profile)
                         .find(params[:id])
end
```

- 既存のデータ（画像・デバイス）を個別に削除・解除できるようにしています。

```ruby
# app/controllers/desk_setups_controller.rb

def update
  @desk_setup = DeskSetup.find(params[:id])

  # 1. 選択された画像のみをピンポイントで削除 (ActiveStorage)
  if params[:desk_setup][:delete_image_ids].present?
    image_ids = params[:desk_setup][:delete_image_ids].reject(&:blank?)
    image_ids.each do |image_id|
      @desk_setup.images.find(image_id).purge
    end
  end

  # 2. 選択されたデバイスの紐付けのみを解除（デバイスのマスタデータは消さない）
  if params[:desk_setup][:delete_device_ids].present?
    device_ids = params[:desk_setup][:delete_device_ids].reject(&:blank?)
    devices_to_delete = @desk_setup.devices.where(id: device_ids)
    @desk_setup.devices.delete(devices_to_delete)
  end

  # ...更新処理へ続く
end
```

### 6. 💡 スタイル設定機能

| スタイル選択フロー |
| :---: |
| ![ezgif com-video-to-gif-converter (7)](https://github.com/user-attachments/assets/f5e3c29f-bc53-455e-82fe-11ec0e482da5) |

- 投稿時にユーザーのデスクの雰囲気を大まかに下記5つから選択していただきます。
  - ミニマル
  - ゲーミング
  - ナチュラル
  - ワークスペース
  - クリエイター
- 単なる文字列（String）ではなく、独立したマスターデータ（`Style` モデル）として切り出し、`belongs_to` で関連付ける設計（テーブルの正規化）を採用しています。

**【モデルの関連付け】**
```ruby
# app/models/desk_setup.rb
class DeskSetup < ApplicationRecord
  belongs_to :style
  # 他にもDeviceとの多対多の関連付けやタグ機能を実装
end

# app/models/style.rb
class Style < ApplicationRecord
  has_many :desk_setups
end
```

**【冪等性を意識したデータ投入】**
```ruby
# db/seeds.rb
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
```

### 7. 🏷️ タグ付け機能

| タグ作成・削除フロー |
| :---: |
| ![ezgif com-video-to-gif-converter (8)](https://github.com/user-attachments/assets/c7fe65a5-191d-4903-993d-49679b67bdf9) |

- `gem acts-as-taggable-on` と `TomSelect` を利用して実装しました。
- デスク環境のこだわりやポイント、特徴を自由なキーワードでタグ付けできます。
- 直感的でストレスのない入力体験を意識して実装しました。

**1. Stimulusへの分離**
- バックエンドには `acts-as-taggable-on` を採用しつつ、フロントエンドには **Hotwire(Stimulus)** と `TomSelect` の組み合わせにて実装しています。

```ruby
# app/views/desk_setups/new.html.erb
<div>
  <%= f.label :tag_list, class: "flex items-center gap-2 mb-2 text-sm font-bold text-[#1f2937]" do %>
    <i class="fas fa-tags text-[#4182fa]"></i> タグ
  <% end %>
  <%= f.select :tag_list, 
      DeskSetup.tags_on(:tags).map { |t| [t.name, t.name] },
      { include_blank: true },
      { multiple: true, data: { controller: "tags" }, class: "w-full bg-white border-[#c7d2fe] rounded-md text-[#1f2937] focus:border-[#4182fa] focus:ring-[#4182fa]" }
  %>
</div>
```

**2. TomSelectのカスタマイズとTurboへの対応**
- ライブラリの導入だけではなく、ユーザーが新しいタグを作成する際のUIをカスタマイズしています。
- リアルタイムで「Add'...'」というサジェストを表示し、シームレスにタグ化できるようにしました。
- Turboによる画面遷移時にJSのバグを防ぐため `disconnect()` を用いてインスタンスの破棄を行なっています。

```javascript
// app/javascript/controllers/tags_controller.js
import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

export default class extends Controller {
  connect() {
    this.tomSelect = new TomSelect(this.element, {
      plugins: ['remove_button'],
      create: true,
      onItemAdd: function(){
        this.setTextboxValue('');
        this.refreshOptions();
      },
      render: {
        option_create: function(data,escape){
          return'<div class="create">Add<strong>' + escape(data.input) + '</strong>&hellip;</div>';
        },
        no_results: function(data,escape){
          return'<div class="no-results">NO results found for "' + escape(data.input) + '"</div>';
        },
      }
    })
  }

  // Turboの画面遷移バグを防ぐためのお片付け処理
  disconnect(){
    if (this.tomSelect) {
      this.tomSelect.destroy()
    }
  }
}
```

### 8. 🎮 デバイス紐付け機能 

| デバイス追加フロー |
| :---: |
| ![ezgif com-video-to-gif-converter (9)](https://github.com/user-attachments/assets/64a1c7a9-667e-4a23-b305-b591d5503b47) |

- デスク環境を構築する要素のデバイスを検索し、ユーザーのセットアップに紐付ける機能です。
- Hotwireを利用して軽量かつサクサク動く入力体験を目指し実装しました。

 **1. HotwireによるSPA風の非同期検索**
 - 検索フォームにてEnterキーを押した際、画面全体ではなく検索結果のみを非同期にて高速描写しています。
 - StimulusによるDOM操作と重複選択防止のバリデーションを実装することでユーザーのストレスを軽減する実装にしています。

```javascript
// app/javascript/controllers/device_picker_controller.js
export default class extends Controller {
  // EnterキーでTurbo FrameのURLを書き換え、非同期検索を実行
  search(e) {
    if (e.key === 'Enter') {
      e.preventDefault()
      const frame = document.getElementById("search_results")
      if (frame) frame.src = `/devices/search?q=${e.target.value}`
    }
  }

  // 選択されたデバイスを動的にDOM追加し、隠しパラメータとしてフォームにセット
  add(e) {
    const { id, brand, name } = e.params
    // 重複チェック
    if (this.selectedListTarget.querySelector(`input[value="${id}"]`)) {
      alert("そのデバイスはすでに追加されています")
      return
    }
    // ... hiddenタグ(desk_setup[device_ids][])の動的生成処理 ...
  }
}
```

**2. ArelとN+1対策を組み合わせた検索ロジック**
- 環境差異の吸収 : 開発(SQLite)と本番(PostgreSQL)環境での大文字小文字判定の差異をなくすため `Arel` の `.matches` を利用しています。
- クエリの最適化 : 曖昧な記憶でも探せるように **デバイス名は部分一致** 、誤ヒットを防ぐため **カテゴリー名は完全一致** と条件を細分化しています。
- N+1問題への対策 : `joins` による絞り込みと同時に `includes(:category)` を書き込むことでカテゴリー名表示のN+1問題を未然に防いでいます。

```ruby
# app/controllers/devices_controller.rb
def search
  if params[:q].present?
    partial_keyword = "%#{params[:q]}%"  
    exact_keyword   = params[:q]         
    t_devices = Device.arel_table
    t_categories = Category.arel_table

    @devices = Device.joins(:category).includes(:category).where(
      t_devices[:brand_name].matches(partial_keyword)
      .or(t_devices[:name].matches(partial_keyword))
      .or(t_categories[:name].matches(exact_keyword))
      .or(t_categories[:name_ja].matches(exact_keyword))
    )
  else
    @devices = Device.order(created_at: :desc).limit(10)
  end
end
```

**3. 冪等性を担保したデータ運用**
- 運用後にマスターデータ（カテゴリーやスタイル）を追加するケースを想定して、「Upsert処理」を実装しています。
- 既存のデータを破壊することなく安全に何度でも実行可能なデータ設計を行いました。

```ruby
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
```

## ✨ 工夫したところ

### 🛠️ 技術面の工夫

- EagerLoadingによるN+1問題の排除
  - デスク環境一覧(index)や詳細（show）を表示する際に関連するモデル   
  `.includes(:user, :style, :tags)` などやネストした関連付け `user: :profile` などを事前に読み込んでいます。  
  これにより、何件データがあってもSQLの発行回数を最小限に抑え、本番環境においても高速なページレンダリングを行っています。
- メールアドレス・ユーザーIDによる柔軟なログイン
  - Deviseの `find_for_database_authentication` をオーバーライドを行い  
  フォームに「メールアドレス」、「ユーザーID」のどちらも入力できる仮想属性を実装しました。  
  さらに、 `lower()` を利用して大文字小文字の違いも吸収することでユーザーの記憶違いによるログインエラーを減らしました。
- SPAライクな操作、ユーザー目線の検索機能
  - Hotwireを駆使してデバイス検索時の非同期リロードや、DOM操作による動的なフォーム生成を行うことで   
  ページ遷移のストレスを減らした操作感を実装しました。
  - 実装当初 **完全一致** のみでヒットしにくかったものをレビューから学び、「Mouse」と「マウス」   
  「Logicool」と「logicool」など大文字・小文字や日英の表記ゆれをシステム側で吸収   
  ユーザーが思いついたキーワードにて直感的に検索しても、確実に目的のデータに辿り着けるような機能に作り上げました。

### 👤 ユーザー面の工夫

- 直感的でテンプレート的なUI
  - 作成目的にもある **ハードルの高さ** をクリアするために投稿時に行う操作をテンプレート的な動線にすることで   
  初めてのアプリ操作においても迷いなく投稿まで行えるUIに仕上げました。
- 思考を止めないタグ入力
  - TomSelectを導入するだけではなくUIをカスタマイズすることで、Enterキーでの連続入力やサジェスト、入力後の自動クリア   
  などのタイピングの勢いを止めずにユーザーがサクサク新しいタグを登録できたり、既存のタグを利用できるような心地よさにこだわり実装しました。

## 🗺️ 今後の実装予定

- 複数条件を備えた検索機能
- いいねやコメントなどのユーザー交流機能
- フォロー機能
- 投稿物の編集時に画像、デバイスを新しく追加する機能
- 外部APIを利用したデバイス検索機能の一新

## 🙇 おわりに

最後までお読みいただきありがとうございました！
本アプリ「@dEvicE」は私自身の感じていた自身のデスク環境を共有するハードルの高さを払拭できるアプリという課題を元に作成しました。   
今回の自分の手でアプリを最後まで作るという経験は今後の糧になると考えています。   
今後も改善・改修を行なっていきますので、ご意見ご要望などございましたら下記よりご連絡ください。　　　
- 学習のアウトプットとして本リポジトリとして公開しています。
- ご感想などいただけると嬉しく思います。

---

[![X](https://img.shields.io/badge/X-%23000000.svg?style=for-the-badge&logo=X&logoColor=white)](https://x.com/t_resk4)
