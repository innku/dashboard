class Dashing.Links extends Dashing.Widget

  @accessor 'quote', ->
    "“#{@get('current_link')?.body}”"

  ready: ->
    @currentIndex = 0
    @linkElem = $(@node).find('.link-container')
    @nextLink()
    @startCarousel()

  onData: (data) ->
    @currentIndex = 0

  startCarousel: ->
    setInterval(@nextLink, 8000)

  nextLink: =>
    links = @get('links')
    if links
      @linkElem.fadeOut =>
        @currentIndex = (@currentIndex + 1) % links.length
        @set 'current_link', links[@currentIndex]
        @linkElem.fadeIn()
