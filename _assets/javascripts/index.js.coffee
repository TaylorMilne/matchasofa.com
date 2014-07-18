# FUNCTIONS
cycleImages = ->
  $active = $(".bgCycler .active")
  $next = (if ($(".bgCycler .active").next().length > 0) then $(".bgCycler .active").next() else $(".bgCycler img:first"))
  $next.addClass "active"
  $active.removeClass "active"
  return


# DOCUMENT READY
$(document).ready ->


  # HOME BACKGROUND CYCLER
  $(".bgCycler").fadeIn 2500
  setInterval (->
    cycleImages()
  ), 7000


  $(".royalSlider").click ->
    $("html, body").animate
      scrollTop: $(this).offset().top
    , 600
    return

  # MARQUEE SLIDER
  # ==============
  $("#marqueeSlider").royalSlider
    imageScaleMode: "fill"
    controlsInside: false
    navigateByClick: false
    sliderDrag: false
    loop: true
    slidesSpacing: 0
    globalCaption: true
    arrowsNavAutoHide: false
    controlNavigation: "arrows"
    numImagesToPreload: 2

  marqueeSlider = $("#marqueeSlider").data("royalSlider")


  # VERSATILITY SLIDER
  # ==================
  $("#versatilitySlider").royalSlider
    controlNavigation: "thumbnails"
    imageScaleMode: "fill"
    arrowsNav: false
    keyboardNavEnabled: true
  versatilitySlider = $("#versatilitySlider").data("royalSlider")
  $("#versatilitySlider .rsThumbs .rsThumb").removeClass("rsNavSelected")
  $("#versatilitySlider").click ->
    $(".section-multifunctional").addClass("visible-full")
    versatilitySlider.updateSliderSize()
    s.refresh()
    return

  # EXPRESS SLIDER
  # ==============
  $("#expressSlider").royalSlider
    imageScaleMode: "fill"
    controlsInside: false
    navigateByClick: true
    loop: true
    slidesSpacing: 0
    globalCaption: true
    arrowsNavAutoHide: false
    controlNavigation: "arrows"
    numImagesToPreload: 2
    autoPlay:
      enabled: true
      pauseOnHover: false


  # INCREMENT UNITS
  units = 1
  $(".sidebar-cta .btn.btn-add").click ->
    units = units+1
    $(".unit-count span").html(units)
    $.get "/units/" + units + ".html", (data) ->
      $("#landing .units").html data
      return


  # LANDINGPAGE PULSE TIMEOUTS
  $(".sidebar-cta .btn.pulse").click ->
    $(this).removeClass "pulse"

    setTimeout (->
      $(".sidebar-cta-video").addClass "pulse"
      return
    ), 1500

    return

  # SIDEBAR CTA VIDEO CLICK ACTIVATE VIDEO
  $(".sidebar-cta-video").click ->
    $("#marqueeSlider .rsPlayBtnIcon").click()


  landingOffset = $(window).height() * 0.4 # this is how much the landing slide decreases in height (60% of window height)
  videoMarqueeOffset = landingOffset - $("#marqueeSlider").offset().top
  videoMarqueePreEnd = videoMarqueeOffset + $("#marqueeSlider").height() - 300
  videoMarqueeEnd = videoMarqueeOffset + $(window).height()

  $(window).scroll ->
    scrollPos = $(window).scrollTop()

    if ((scrollPos >= videoMarqueeOffset) and (scrollPos < videoMarqueePreEnd))
      if (window.location.hash isnt "#video")
        $.history.push "/video"
    else if scrollPos >= videoMarqueePreEnd
      if (window.location.hash isnt "#details")
        $.history.push "/details"
    else if scrollPos < 100
      if (window.location.hash isnt "#/") and (window.location.hash isnt "#") and (window.location.hash isnt "")
        $.history.push "/"
    return



  $.history.on("load change push pushed", (event, url, type) ->
    if event.type is "load"
      scrollSpeed = 0
    else
      scrollSpeed = 600

    scrollPos = $(window).scrollTop()

    if (event.type isnt "load") and (event.type isnt "push") and (event.type isnt "pushed")
      switch url
        when "video"
          $("html, body").animate({
            scrollTop: videoMarqueeOffset
            }, 600);

        when "details"
          $("html, body").animate({
            scrollTop: videoMarqueeOffset + videoMarqueeEnd - landingOffset
            }, 600);

  ).listen "hash"


  # INITIALIZE SKROLLR.
  s = skrollr.init()
  return
