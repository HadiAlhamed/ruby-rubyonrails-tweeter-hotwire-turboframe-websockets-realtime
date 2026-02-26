import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // connect() {
  //   this.element.textContent = "Hello World!"
  // }

  static targets = [
    "form"
  ]

  toggle(event)
  {
    event.preventDefault()
    this.formTarget.classList.toggle("d-none")
  }

}
