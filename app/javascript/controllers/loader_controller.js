import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'container' ]

  show() {
    const loadIcon = document.createElement('i')
    loadIcon.classList.add('fa-solid', 'fa-circle-notch', 'fa-spin')
    this.containerTarget.replaceWith(loadIcon)
  }
}
