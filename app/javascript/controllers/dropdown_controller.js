import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu"]

  connect() {
    document.addEventListener("click", this.closeOnOutsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this.closeOnOutsideClick)
  }

  toggle(event) {
    event.stopPropagation()
    this.menuTarget.classList.toggle("is-open")
  }

  closeOnOutsideClick = (event) => {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.remove("is-open")
    }
  }
}
