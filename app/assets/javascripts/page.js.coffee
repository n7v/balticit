$(document).ready ->
  porfolioShow = ->
    $(".portfolio-item").eq(pItem).addClass "portfolio-show"
    pItem++
  $(".btop-third-link").height $("#btop-first").height() + 10
  pItem = 0
  setInterval porfolioShow, 200
  isMobile = navigator.userAgent.match(/(iPhone|iPod|iPad|Android|BlackBerry)/)
  $(".portfolio-link").on "click", (event) ->
    $("#project").modal backdrop: false
    if isMobile
      $("#project").css "min-height", $(window).height() + "px"
      $("#page").hide()
    else
      $("body").addClass "no-scroll"
      $("#project-body").css("height", $(window).height() - 250 + "px").jScrollPane()
    false

  $("#project-close").on "click", (event) ->
    $("#project").modal "hide"
    if isMobile
      $("#page").show()
    else
      $("body").removeClass "no-scroll"
    false