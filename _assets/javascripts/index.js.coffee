# FUNCTIONS
cycleImages = ->
  $active = $(".bgCycler .active")
  $next = (if ($(".bgCycler .active").next().length > 0) then $(".bgCycler .active").next() else $(".bgCycler img:first"))
  $next.addClass "active"
  $active.removeClass "active"
  return

scrollTo = (scrollTo, speed) ->
  $("html, body").animate
    scrollTop: scrollTo
  , speed


# VARIABLES
transitionSpeed = 500



# DOCUMENT READY
$(document).ready ->

  # HOME BACKGROUND CYCLER
  $(".bgCycler").fadeIn 2500
  setInterval (->
    cycleImages()
  ), 8000


  $(".royalSlider").click ->
    $("html, body").animate
      scrollTop: $(this).offset().top
    , transitionSpeed
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
      enabled: false
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

  # VARIABLES
  landingHeightDecrease = ($(window).height() * 0.6)# this is how much the landing slide decreases in height (60% of window height)
  landingHeight = ($(window).height() * 0.4) #this is the landing height after scrolling down
  videoMarqueeOffset = landingHeight
  videoMarqueePreEnd = videoMarqueeOffset + $("#marqueeSlider").height() - 300
  videoMarqueeEnd = videoMarqueeOffset + $(window).height()


  # SIDEBAR CTA VIDEO CLICK ACTIVATE VIDEO
  $(".sidebar-cta-video").click ->
    $("#marqueeSlider .rsPlayBtnIcon").click()


  # FEATURES NAV ITEM CLICK AND HASH
  # ================================
  featuresOffset = $("#features").offset().top + landingHeight

  $("header nav #nav-features").click ->
    scrollTo(featuresOffset, transitionSpeed)

  if (window.location.hash == "#features")
    setTimeout (->
      scrollTo(featuresOffset, 10)
      return
    ), 50

  # SCROLL TO VIDEO WHEN IT IS IS PLAYED
  # ===================================
  marqueeSlider.ev.on "rsOnCreateVideoElement", (e, url) ->
    $("html, body").animate
      scrollTop: videoMarqueeOffset
    , transitionSpeed
    return


  # INITIALIZE SKROLLR.
  s = skrollr.init()


  # UPDATE SKROLLR AFTER LANDINGSLIDE SHRINK
  skrollrUpdated = false

  scrollPos = $(window).scrollTop()
  updateSkrollr(scrollPos)

  $(window).scroll ->
    scrollPos = $(window).scrollTop()
    updateSkrollr(scrollPos)


  return


updateSkrollr = (scrollPos) ->
  if ((scrollPos > $(window).height()) && (skrollrUpdated == false))
    s.refresh($("#landing"))
    skrollrUpdated = true
    console.log "skrollr updated"
    return
  return
