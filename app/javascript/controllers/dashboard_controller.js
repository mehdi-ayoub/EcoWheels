import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("dashboard controller connected")
  }

 /*  cardsModule = (function () {
    var trigger = $(".item"),
      closetrigger = $(".item span.close");

    var animateCard = function () {
      $(this).addClass("animate");
    };

    var closeCard = function (e) {
      console.log($(this).parent());
      $(this).parent().removeClass("animate");
      e.stopPropagation();
    };

    trigger.on("click", animateCard);
    closetrigger.on("click", closeCard);
  })(); */
  toggleAnimate(event) {
    event.currentTarget.classList.toggle("animate")

  }
}
