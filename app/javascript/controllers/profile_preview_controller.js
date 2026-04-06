import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile-preview"
export default class extends Controller {
  static targets = ["input", "preview", "icon"]

  display() {
    // inputタグからユーザーが選択した１枚目の画像データ本体を取得する
    const file = this.inputTarget.files[0]

    if (file) {
      // ブラウザにて表示できるように画像データから一時的なプレビュー用URLを生成
      const blobUrl = window.URL.createObjectURL(file)
// 背景画像 (<div>) かアバター画像 (<img>) かをタグ名にて判断
      if (this.previewTarget.tagName === "IMG") {
        // アバター画像は<img>タグを使用している -> src　一時URLに書き換える
        this.previewTarget.src = blobUrl
        this.previewTarget.classList.remove("hidden")
      }else{
        // 背景の場合 -> CSSの「background-image」を一時URLにて上書き処理する
        this.previewTarget.style.backgroundImage = `url(${blobUrl})`
      }
// 既存のアバターがある場合隠す
      if (this.hasIconTarget) {
        this.iconTarget.classList.add("hidden")
      }
    }
  }
}
