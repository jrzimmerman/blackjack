class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png" />'

  initialize: -> @render()

  render: ->
    html = if @model.get('revealed')
      @template @model.attributes
    else
      '<img src="img/card-back.png" />'
    @$el.children().detach()
    @$el.html html
    # @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

