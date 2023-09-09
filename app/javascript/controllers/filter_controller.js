import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Filter controller connected!");
  }

  filterByStatus(event) {
    // Prevent the default behavior of the link
    event.preventDefault();

    // Navigate to the link's URL to apply the filter
    window.location.href = event.currentTarget.href;
  }
}
