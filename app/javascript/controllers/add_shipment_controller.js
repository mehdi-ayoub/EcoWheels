import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-shipment"
export default class extends Controller {
  static targets = ["modal"]

  connect() {
  }

  open() {
    this.modalTarget.style.display = "flex";
    }

  close() {
    this.modalTarget.style.display = "none";
  }

}
