$ ->

  translations = ->

    $(".activeadmin-translations > ul").each ->
      $dom = $(this)
      if !$dom.data("ready")
        $dom.data("ready", true)
        $tabs = $("li > a", this)
        $default_tab = $("li > a.active", this)
        $contents = $(this).siblings("fieldset")

        activate = (tab,tabs) ->
          tabs.not(tab).removeClass("active")
          tab.addClass("active")
          $contents.hide()
          $contents.filter(tab.attr("href")).show()

        $tabs.click ->
          $tab = $(this)
          activate($tab, $tabs)
          false

        $tabs.eq(0).click()

        $tabs.each ->
          $tab = $(@)
          $content = $contents.filter($tab.attr("href"))
          containsErrors = $content.find(".input.error").length > 0
          $tab.toggleClass("error", containsErrors)

        activate($default_tab,$tabs)


  # this is to handle elements created with has_many
  $("a").bind "click", ->
    setTimeout(
      -> translations()
      50
    )

  translations()

