$ ->
  translations = ->
    $(".activeadmin-translations").each ->
      $dom = $(this)
      if !$dom.data("ready")
        $links = $('.dropdown_menu_list > li > a', this)
        $button = $('.dropdown_menu_button')
        $active_link = $('.dropdown_menu_list > li > a.active', this)
        $contents = $(this).find("fieldset")
        $contents.hide()
        $contents.filter($active_link.attr("href")).show()
        $button.text($active_link.text())

        $links.click ->
          $link = $(this)
          $links.removeClass('active')
          $link.addClass('active')
          false

        $links.each ->
          $link = $(@)
          $content = $contents.filter($link.attr("href"))
          containsErrors = $content.find(".input.error").length > 0
          $link.toggleClass("error", containsErrors)

  # this is to handle elements created with has_many
  $("a").bind "click", ->
    setTimeout(
      -> translations()
      50
    )

  translations()

