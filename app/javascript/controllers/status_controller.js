// app/javascript/controllers/status_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["select"];

  connect() {
    console.log("Stimulus controller connected!");
    console.log(this.selectTarget)
  }

  updateStatus() {
    // Fetch the form elements
    const form = this.selectTarget.form;
    const actionURL = form.action;
    const methodType = form.method;

    // Create FormData object from the form element
    const formData = new FormData(form);

    // Use Fetch API to make an AJAX request
    fetch(actionURL, {
      method: 'Post', // typically this will be 'POST' or 'PUT'
      body: formData,
      headers: {
        "Accept": "application/json",             // Expecting JSON response
        "X-Requested-With": "XMLHttpRequest",     // Indicate the request is AJAX
      },
    })
    .then(response => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.json();
    })
    .then(data => {
      // Handle the response here
      if (data.status === "success") {
        // You can update UI or show a success message
      } else {
        // Handle error, maybe show an error message
      }
    })
    .catch(error => {
      console.error("There was a problem with the fetch operation:", error.message);
      // Handle error, maybe show an error message
    });
  }
}
