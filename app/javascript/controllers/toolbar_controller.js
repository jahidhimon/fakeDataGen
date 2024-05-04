import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toolbar"
export default class extends Controller {
  static targets = ["errorField", "errorRange", "getform", "seedField"]

  connect() {
    console.log("toolbar connected")
    this.changeErrorRange()
  }

  changeErrorField() {
    this.errorFieldTarget.value = this.errorRangeTarget.value
    this.submitForm()
  }

  changeErrorRange() {
    this.errorRangeTarget.value = Math.min(this.errorFieldTarget.value, 10)
  }

  submitForm() {
    this.getformTarget.submit()
  }

  generateRandomSeed(event) {
    event.preventDefault()
    seed = Math.floor(Math.random() * (1 << 30) + 1)
    this.seedFieldTarget.value = seed
    this.submitForm()
  }
}
