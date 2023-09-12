// import { Controller } from "@hotwired/stimulus";
// import Swal from "sweetalert2";

// export default class extends Controller {
//   connect() {
//     console.log("Delete confirmation controller connected!");
//   }

//   confirm(event) {
//     event.preventDefault();

//     const deleteLink = event.currentTarget.href; // Store the href value here

//     Swal.fire({
//       title: 'Are you sure?',
//       text: 'You are about to delete this shipment.',
//       icon: 'warning',
//       customClass: {
//         confirmButton: 'custom-confirm-button-class',
//         cancelButton: 'custom-cancel-button-class',
//         title: 'custom-title-class',
//         popup: 'custom-popup-class',
//         // Add more classes as needed
//       },
//       showCancelButton: true,
//       confirmButtonColor: '#d33',
//       cancelButtonColor: '#3085d6',
//       confirmButtonText: 'Yes, delete it!'
//     }).then((result) => {
//       if (result.isConfirmed) {
//         // If user confirms, then redirect to the delete link
//         fetch(event.currentTarget.href, {
//           method: 'DELETE',
//           headers: {
//             'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").content
//           }
//         }).then(response => {
//           if (response.ok) {
//             // Redirect or refresh the page after successful deletion
//             window.location.href = '/desired_redirect_path';  // Replace with your desired path
//           } else {
//             console.error('Failed to delete shipment.');
//           }
//         });      }
//     });
//   }
// }
