var cardsModule = (function () {
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
})();
