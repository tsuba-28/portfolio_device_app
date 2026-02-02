import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="images"
export default class extends Controller {
  static targets = ["input", "preview", "dropZone"]

  connect() {
    this.dataTransfer = new DataTransfer()
  }

  handleFiles(files) {
    if(files.length === 0) return
// サイズ制限の設定　（１０MB）　
    const MAX_SIZE_MB = 10
    const MAX_SIZE_BYTES = MAX_SIZE_MB * 1024 * 1024
    let hasError = false
// サイズチェック処理
    Array.from(files).forEach(file => {
      if (file.size > MAX_SIZE_BYTES) {
        alert(`ファイル「${file.name}」は大きすぎます。\n${MAX_SIZE_MB}MB以下の画像を選択してください。`)
        hasError = true
        return  // ファイルを追加せずにスキップする　（次のファイルの処理へ進む）
      }
      this.dataTransfer.items.add(file) // サイズがOKなら追加
    })
// inputタグの中身を更新
    this.inputTarget.files = this.dataTransfer.files
// プレビューを再描画する
    this.updataPreview()
  }

  updataPreview() {
    this.previewTarget.innerHTML = ""

    Array.from(this.dataTransfer.files).forEach((file, index) => {
      const render = new FileReader()

      render.onload = (e) => {
        const div = document.createElement("div")
        div.className = "relative group"
// 画像
        const img = document.createElement("img")
        img.src = e.target.result
        img.className = "w-full h-32 object-cover rounded-lg border border-gray-200"
// 削除ボタン
        const deleteBtn = document.createElement("button")
        deleteBtn.type = "button"
        deleteBtn.className = "absolute top-1 right-1 bg-white round-full p-1 shadow hover:bg-red-50 text-gray-500 hover:text-red-500 transition-colors"
        deleteBtn.innerHTML = '<i class="fa-solid fa-xmark w-4 h-4 flex items-center justify-center"></i>'

        deleteBtn.onclick = () => this.removeFile(index)

        div.appendChild(img)
        div.appendChild(deleteBtn)
        this.previewTarget.appendChild(div)
      }

      render .readAsDataURL(file)
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
    this.updataPreview()
  }

// イベントハンドラ

  preview() {
    this.handleFiles(this.inputTarget.files)
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
