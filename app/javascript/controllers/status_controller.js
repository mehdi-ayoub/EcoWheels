// app/javascript/controllers/status_controller.js
import { Controller } from "@hotwired/stimulus";

const getMetaValue = (name) =>
  document.head.querySelector(`meta[name="${name}"]`)?.getAttribute("content") ?? null;

export default class extends Controller {
  static targets = ["select"];

  connect() {
    console.log('Status Controller is connected');
    this.updateButtonColor(); // Update the button color on connect
  }

  updateStatus(event) {
    const statusValue = event.target.value;
    const shipmentId = event.target.closest('tr').dataset.shipmentId;

    console.log("Captured shipmentId:", shipmentId);
    console.log("statusValue:", statusValue);

    fetch(`/shipments/${shipmentId}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': getMetaValue("csrf-token"),
        'Accept': 'application/json'
      },
      body: JSON.stringify({ shipment: { status: statusValue } })
    })
    .then(response => response.json())
    .then(data => {
      if (data.status === "success") {
        const shipmentRow = document.getElementById(`shipment-${shipmentId}`);

        if (shipmentRow) {
          shipmentRow.remove();
        } else {
          console.log("Shipment row NOT found.");
        }
      } else {
        console.log("Failed to update shipment status.");
      }
    })
    .catch(error => {
      console.error("There was an error:", error);
    });

    this.updateButtonColor(); // Update the button color after changing status
  }

  updateButtonColor() {
    const selectedStatus = this.selectTarget.value;
    this.selectTarget.className = '';  // Reset all classes
    this.selectTarget.classList.add('btn', 'btn-light', 'status-index-button-new');

    switch (selectedStatus) {
      case 'scheduled':
        this.selectTarget.classList.add('btn-yellow');
        break;
      case 'completed':
        this.selectTarget.classList.add('btn-green');
        break;
      // ... add other cases if needed
    }
  }
}
