import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="device-picker"
export default class extends Controller {
// 追加ボタンなど
  static targets = ["searchArea", "toggleButton", "selectedList"]

  toggle() {
// ボタンを見えないようにする処理
    this.searchAreaTarget.classList.toggle("hidden")
  }
// 検索処理
  search(event) {
    if (event.key === 'Enter') {
      event.preventDefault()

      const query = event.target.value
      const frame = document.getElementById("search_results")

      if (frame) {
        frame.src = `/devices/search?q=${query}`
      }
    }
  }

  add(event) {
    const { id, brand, name } = event.params
// 重複アラート
    const existingItem = this.selectedListTarget.querySelector(`input[value="${id}"]`)
    if (existingItem) {
      alert("そのデバイスはすでに追加されています")
      return
    }
// 外枠
    const wrapper = document.createElement("div")
    wrapper.classList.add("select-device-item")
// 隠しデータ
    const input = document.createElement("input")
    input.type = "hidden"
    input.name = "desk_setup[device_ids][]"
    input.value = id
    wrapper.appendChild(input)
// 表示テキスト
    const textSpan = document.createElement("span")
    const strongBrand = document.createElement("strong")
    strongBrand.textContent = brand

    textSpan.appendChild(strongBrand)
    textSpan.append(` ${name} `)
    wrapper.appendChild(textSpan)
// 削除ボタン
    const deleteBtn = document.createElement("button")
    deleteBtn.type = "button"
    deleteBtn.textContent = "×"
    deleteBtn.setAttribute("data-action", "click->device-picker#remove")
    wrapper.appendChild(deleteBtn)
// 画面表示
    this.selectedListTarget.appendChild(wrapper)
  }
// 要素を探して削除処理
  remove(event) {
    event.target.closest('.select-device-item').remove()
  }
}
