import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu"]

  connect() {
    // 画面のどこかをクリックした時のイベントを監視
    document.addEventListener("click", this.closeOnOutsideClick)
  }

  disconnect() {
    // 画面遷移などでコントローラーが消える時に監視を終了する
    document.removeEventListener("click", this.closeOnOutsideClick)
  }

  toggle(event) {
    event.stopPropagation()
    this.menuTarget.classList.toggle("hidden")
  }

  closeOnOutsideClick = (event) => {
    // クリックされた場所が、コントローラーの内側の場合何もしない
    if (this.element.contains(event.target)) return
    // 外側がクリックされた場合、hiddenクラスをつけて隠す
    this.menuTarget.classList.add("hidden")
  }
}
