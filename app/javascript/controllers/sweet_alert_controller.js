import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

// Connects to data-controller="sweet-alert"
export default class extends Controller {

  connect() {
    console.log('it works')
  }

  initSweetalert(event) {
    event.preventDefault();

    Swal.fire({
      title: 'Are you sure?',
      text: 'You are about to create a new shipment',
      
      customClass: {
        confirmButton: 'custom-confirm-button-class',
        cancelButton: 'custom-cancel-button-class',
        title: 'custom-title-class',
        popup: 'custom-popup-class',
        // Add more classes as needed
      },

      imageUrl: 'https://i.pinimg.com/736x/35/7c/51/357c51eb56f48d0b50dcaf1f003afbe7.jpg',
      imageWidth: 300,
      imageHeight: 200,
      imageAlt: 'Custom image',
      showCancelButton: true,
      confirmButtonText: 'Yes, create!',
      cancelButtonText: 'No, cancel',
    }).then((result) => {
      if (result.isConfirmed) {
        // If the user confirms, submit the form
        const form = event.target.closest('form');
        form.submit();
      }
    });
  }
}
