import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  connect() {
    console.log("Filter controller connected!");
  }

  filterByStatus(event) {
    event.preventDefault();

    const targetURL = event.currentTarget.href;

    fetch(targetURL, {
      headers: {
        "Accept": "text/html"
      }
    })
    .then(response => response.text())
    .then(data => {
      const parser = new DOMParser();
      const doc = parser.parseFromString(data, "text/html");
      const newTableBody = doc.querySelector(".tbody-index");

      // Replace the old table body with the new one
      const oldTableBody = this.element.querySelector(".tbody-index");
      oldTableBody.replaceWith(newTableBody);
    })
    .catch(error => {
      console.error("There was a problem with the fetch operation:", error.message);
    });
  }

  updateStatus(event) {
    // Assuming you are using a form to update the status
    event.preventDefault();

    const form = event.currentTarget;
    const actionURL = form.action;
    const formData = new FormData(form);

    // Use Fetch API to make an AJAX request
    fetch(actionURL, {
      method: 'POST',
      body: formData,
      headers: {
        "Accept": "application/json",
        "X-Requested-With": "XMLHttpRequest",
      },
    })
    .then(response => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.json();
    })
    .then(data => {
      if (data.status === "success") {
        // Fetch the current filtered shipments again and replace the table
        const currentFilter = new URL(window.location.href).searchParams.get("status");
        const targetURL = `/shipments?status=${currentFilter}`;

        fetch(targetURL, {
          headers: {
            "Accept": "text/html"
          }
        })
        .then(response => response.text())
        .then(data => {
          const parser = new DOMParser();
          const doc = parser.parseFromString(data, "text/html");
          const newTableBody = doc.querySelector(".tbody-index");

          const oldTableBody = this.element.querySelector(".tbody-index");
          oldTableBody.replaceWith(newTableBody);
        });
      } else {
        // Handle error, maybe show an error message
      }
    })
    .catch(error => {
      console.error("There was a problem with the fetch operation:", error.message);
    });
  }
}
