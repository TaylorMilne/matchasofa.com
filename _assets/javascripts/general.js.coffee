# VARIABLES
transitionSpeed = 500

clickTabBasedOnHash = ->
  $("ul[data-tabs] li > a[href='" + window.location.hash + "'], ul[data-pills] > li > a[href='" + window.location.hash + "']").click()
  return


# DOCUMENT READY
$(document).ready ->
  if (window.location.hash)
    clickTabBasedOnHash()

  $(window).on "hashchange", ->
    clickTabBasedOnHash()
