import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="device-picker"
export default class extends Controller {
  static targets = ["searchArea", "toggleButton", "selectedList"]

  toggle() {
    this.searchAreaTarget.classList.toggle("hidden")
    // this.toggleButtonTarget.classList.toggle("hidden")
  }

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
    const html = `
      <div class="select-device-item">
        <input type="hidden" name="desk_setup[device_ids][]" value="${id}">
        <span><strong>${brand}</strong> ${name}</span>

        <button type="button" onclick="this.closest('.select-device-item').remove()">
          x
        </button>
      </div>
    `

    this.selectedListTarget.insertAdjacentHTML('beforeend', html)
  }
}
