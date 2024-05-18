import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static outlets = [ 'loader' ]

  showLoader() {
    this.loaderOutlet.show()
  }
}
