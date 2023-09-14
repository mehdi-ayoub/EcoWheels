// info-popup_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  connect() {
    // Attach the listener to the entire document
    document.addEventListener('click', this.handleOutsideClick.bind(this));
  }

  disconnect() {
    // Remove the listener when the controller is no longer used
    document.removeEventListener('click', this.handleOutsideClick.bind(this));
  }

  toggle(event) {
    if (this.modalTarget.style.display === "none") {
      this.modalTarget.style.display = "block";
      event.stopPropagation(); // Prevent the click from reaching the document when opening
    } else {
      this.modalTarget.style.display = "none";
    }
  }

  handleOutsideClick(event) {
    // If the modal is open and the click is outside of the modal, then close it
    if (this.modalTarget.style.display === "block" && !this.element.contains(event.target)) {
      this.modalTarget.style.display = "none";
    }
  }
}
