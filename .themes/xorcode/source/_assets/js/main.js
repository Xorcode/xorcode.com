(function() {
  $(function() {
    $('.tooltip-examples a, .tooltip-paragraph-examples a').tooltip({
      animation: false
    });

    $('.top-sign-in').on("click", function(e) {
      $('.login-box').fadeIn("fast");
      return false;
    });

    $('.login-box-close').on("click", function(e) {
      $(this).closest(".login-box").fadeOut("fast");
      return false;
    });

    prettyPrint();

    $(".slider-browser-center").animate({
      bottom: $(".slider-browser-center").data('position-bottom')
    }, "fast", function() {
      return $(".slider-browser-left").animate({
        bottom: $(".slider-browser-left").data('position-bottom')
      }, "fast", function() {
        return $(".slider-browser-right").animate({
          bottom: $(".slider-browser-right").data('position-bottom')
        }, "fast");
      });
    });

    $('.carousel').carousel({
      interval: false
    });

    /* Thanks to CSS Tricks for pointing out this bit of jQuery
     * http://css-tricks.com/equal-height-blocks-in-rows/
     * It's been modified into a function called at page load and 
     * then each time the page is resized. One large modification
     * was to remove the set height before each new calculation.
     */
    var equalheight = function (container) {
      var currentTallest = 0
        , currentRowStart = 0
        , rowDivs = new Array()
        , $el
        , topPosition = 0;
      $(container).each(function () {
        $el = $(this);
        $el.height('auto').position('relative');
        $el.find('.btn-primary.btn-extra.pull-right').css({
            position: 'relative'
          , bottom: 'inherit'
          , right: 'inherit'
        });
        topPostion = $el.position().top;

        if (currentRowStart != topPostion) {
          for (currentDiv = 0 ; currentDiv < rowDivs.length ; currentDiv++) {
            rowDivs[currentDiv].height(currentTallest);
          }
          rowDivs.length = 0;
          currentRowStart = topPostion;
          currentTallest = $el.height();
          rowDivs.push($el);
        } else {
          rowDivs.push($el);
          currentTallest = (currentTallest < $el.height()) ? ($el.height()) : (currentTallest);
        }
        $.each(rowDivs, function () {
          $(this).height(currentTallest).css('position', 'relative').find('.btn-primary.btn-extra.pull-right').css({
              position: 'absolute'
            , bottom: 10
            , right: 10
          });
        });
      });
    };

    $(window).load(function () {
      equalheight('.row .equal .white-card');
    });

    $(window).resize(function () {
      equalheight('.row .equal .white-card');
    });

    return $('a[data-toggle="testimonial"]').on("click", function(e) {
      $(this).closest('.testimonials-users').find('a[data-toggle="testimonial"]').removeClass("active");
      $(this).addClass("active");
      $('.testimonials-speech').removeClass('active');
      $('.testimonials-speech' + $(this).attr('href')).addClass('active');
      return false;
    });
  });

  $("body").on("touchstart.dropdown", ".dropdown-menu", function(e) {
    return e.stopPropagation();
  });

  return $(document).on("click", ".dropdown-menu a", function() {
    return document.location = $(this).attr("href");
  });

}).call(this);
