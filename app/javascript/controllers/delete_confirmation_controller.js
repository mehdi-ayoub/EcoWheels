import { Controller } from "@hotwired/stimulus";
import Swal from "sweetalert2";

export default class extends Controller {
  connect() {
    console.log("Delete confirmation controller connected!");
  }

  confirm(event) {
    event.preventDefault();

    const deleteLink = event.currentTarget.href;

    Swal.fire({
      title: 'Are you sure?',
      text: 'You will not be able to recover this shipment!',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonClass: 'btn-danger',
      confirmButtonText: 'Yes, delete it',
      cancelButtonText: 'No, cancel',
      reverseButtons: true
    }).then((result) => {
      if (result.isConfirmed) {
        this.deleteItem(deleteLink);
        Swal.fire('Deleted!', 'Your shimpent has been deleted.', 'success');
      } else {
        Swal.fire('Cancelled', 'Your shipment is safe :)', 'error');
      }
    });
  }

  deleteItem(deleteLink) {
    fetch(deleteLink, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").content
      }
    }).then(response => {
      if (!response.ok) {
        console.error('Failed to delete item.');
      }
      window.location.href = '/shipments';
    });
  }
}
