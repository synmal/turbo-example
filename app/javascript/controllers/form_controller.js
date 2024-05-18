import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'form' ]

  reset(event) {
    if(event.detail.success) {
      this.formTarget.reset()
    }
  }
}
