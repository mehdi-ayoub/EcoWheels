import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  // Inform the controller that it has two targets in the form, which are our inputs
  static targets = [ "startTime", "endTime" ]

  connect() {
    console.log(this.startTimeTarget);
    flatpickr(this.startTimeTarget, {})
    console.log(this.endTimeTarget);
    flatpickr(this.endTimeTarget, {})

  }
}
