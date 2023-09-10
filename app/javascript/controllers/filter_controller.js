import { Controller } from "@hotwired/stimulus";

const getMetaValue = (name) =>
  document.head.querySelector(`meta[name="${name}"]`)?.getAttribute("content") ?? null;

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
}
