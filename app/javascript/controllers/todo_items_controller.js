import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'action' ]

  showActions() {
    this.actionTarget.classList.remove('d-none')
    this.actionTarget.classList.add('d-flex')
  }

  hideActions() {
    this.actionTarget.classList.remove('d-flex')
    this.actionTarget.classList.add('d-none')
  }
}
