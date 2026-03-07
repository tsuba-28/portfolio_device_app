import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    // 3秒（３０００ミリ秒）後に消す処理を実行
    setTimeout(() => {
      this.dismiss()
    }, 3000)
  }

  dismiss() {
    // ふわっと消えるアニメーションの設定
    this.element.classList.add("opacity-0", "transition-opacity", "duration-500")

    // アニメーションが終わった後に要素を完全に削除
    setTimeout(() => {
      this.element.remove()
    }, 500)
  }
}
