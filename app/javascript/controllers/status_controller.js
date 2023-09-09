// app/javascript/controllers/status_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["select"];

  connect() {
    console.log("Stimulus controller connected!");
  }

  updateStatus() {
    this.selectTarget.form.submit();
  }
}
