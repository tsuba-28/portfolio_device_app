import { Controller } from "@hotwired/stimulus"
// 定数の定義（最大保存枚数、最大画像サイズ）
const MAX_FILES = 5
const MAX_SIZE_MB = 10
const MAX_SIZE_BYTES = MAX_SIZE_MB * 1024 * 1024

// Connects to data-controller="images"
export default class extends Controller {
  static targets = ["input", "preview", "dropZone", "currentCount", "maxCount"]

  connect() {
// 初期表示 : 最大枚数をセット
    if (this.hasMaxCountTarget) {
      this.maxCountTarget.textContent = MAX_FILES
    }
// 初期表示 : 現在の枚数を０にセット
    if (this.hasCurrentCountTarget) {
      this.currentCountTarget.textCount = 0
    }
    this.dataTransfer = new DataTransfer()
  }

  handleFiles(files) {
    if(files.length === 0) return
// 枚数制限チェック　「現在の枚数」＋「今回追加した枚数」にチェック
    if(this.dataTransfer.files.length + files.length > MAX_FILES) {
      alert(`画像は最大${MAX_FILES}枚までです。`)
      return
    }

// サイズチェック処理
    let hasError = false
    Array.from(files).forEach(file => {
      if (file.size > MAX_SIZE_BYTES) {
        alert(`ファイル「${file.name}」は大きすぎます。\n${MAX_SIZE_MB}MB以下の画像を選択してください。`)
        hasError = true
      } else {
        this.dataTransfer.items.add(file) // サイズがOKなら追加
      }
    })

    if (hasError) return
// inputタグの中身を更新
    this.inputTarget.files = this.dataTransfer.files
// プレビューと枚数表示を再描画
    this.updatePreview()
  }

  updatePreview() {
    this.previewTarget.innerHTML = "" // プレビューエリアのクリア
// 現在の枚数を更新処理
    if (this.hasCurrentCountTarget) {
      this.currentCountTarget.textContent = this.dataTransfer.files.length
    }
// 画像のプレビュー処理
    Array.from(this.dataTransfer.files).forEach((file, index) => {
      const reader = new FileReader()

      reader.onload = (e) => {
        const div = document.createElement("div")
        div.className = "relative w-full aspect-[3/4] group"
// 画像
        const img = document.createElement("img")
        img.src = e.target.result
        img.className = "w-full h-full object-cover rounded-lg border border-gray-200 shadow-sm"
// 削除ボタン
        const deleteBtn = document.createElement("button")
        deleteBtn.type = "button"
        deleteBtn.className = "absolute -top-2 -right-2 bg-white hover:bg-red-500 text-gray-500 hover:text-white rounded-full shadow-md transition-colors duration-200 flex items-center justify-center w-7 h-7 p-0"
        deleteBtn.innerHTML = '<i class="fa-solid fa-times text-sm"></i>'

        deleteBtn.onclick = () => this.removeFile(index)

        div.appendChild(img)
        div.appendChild(deleteBtn)
        this.previewTarget.appendChild(div)
      }

      reader .readAsDataURL(file)
    })
  }

  removeFile(indexToRemove) {
    const newDataTransfer = new DataTransfer()

    Array.from(this.dataTransfer.files).forEach((file, index) =>{
      if (index !== indexToRemove) {
        newDataTransfer.items.add(file)
      }
    })

    this.dataTransfer = newDataTransfer
    this.inputTarget.files = this.dataTransfer.files
    this.updatePreview()
  }

// イベントハンドラ

  preview(e) {
    this.handleFiles(e.target.files)
  }

  dragOver(e) {
    e.preventDefault()
    this.dropZoneTarget.classList.add("border-blue-500", "bg-blue-50")
  }

  dragLeave(e) {
    e.preventDefault()
    this.dropZoneTarget.classList.remove("border-blue-500", "bg-blue-50")
  }

  drop(e) {
    e.preventDefault()
    this.dropZoneTarget.classList.remove("border-blue-500", "bg-blue-50")
    this.handleFiles(e.dataTransfer.files)
  }
}
