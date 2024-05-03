import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toolbar"
export default class extends Controller {
  static targets = ["errorField", "errorRange"]

  connect() {
    console.log("toolbar connected")
  }

  changeErrorField() {
    this.errorFieldTarget.value = this.errorRangeTarget.value
  }
  changeErrorRange() {
    this.errorRangeTarget.value = this.errorFieldTarget.value
  }
}
