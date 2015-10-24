class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': ->
      @model.get('playerHand').hit()
      console.log @model.get('playerHand').scores()[0]
      if @model.get('playerHand').scores()[0] > 21
        @$el.prepend('<h1><div>Busted! You lost!</div></h1>')
        @$el.find('.hit-button').prop('disabled', true)
        @$el.find('.stand-button').prop('disabled', true)
    'click .stand-button': ->
      @$el.find('.hit-button').prop('disabled', true)
      @$el.find('.stand-button').prop('disabled', true)
      @model.get('playerHand').stand()
      @model.get('dealerHand').first().flip()
      @model.get('dealerHand').scores()
      console.log @model.get('dealerHand').scores()
      console.log @model.get('dealerHand').scores()[0]
      @model.get('dealerHand').hit()

      while @model.get('dealerHand').scores()[0] < 17
        @model.get('dealerHand').hit()

      if @model.get('dealerHand').scores()[0] is @model.get('playerHand').scores()[0]
        @$el.prepend('<h1><div>Draw!</div></h1>')

      if @model.get('dealerHand').scores()[0] < @model.get('playerHand').scores()[0]
        @$el.prepend('<h1><div>You Won!</div></h1>')

      if @model.get('dealerHand').scores()[0] > @model.get('playerHand').scores()[0]
        if @model.get('dealerHand').scores()[0] > 21
          @$el.prepend('<h1><div>Dealer Bust! You Won!</div></h1>')
        else
          @$el.prepend('<h1><div>Dealer Wins!</div></h1>')


  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el



    if @model.checkBlackJack() is 'draw'
      @model.get('dealerHand').first().flip()
      @$el.prepend('<h1><div>Draw!</div></h1>')

    if @model.checkBlackJack() is 'player'
      @model.get('dealerHand').first().flip()
      @$el.prepend('<h1><div>BlackJack! You Won!</div></h1>')

    if @model.checkBlackJack() is 'dealer'
      @model.get('dealerHand').first().flip()
      @$el.prepend('<h1><div>BlackJack! Dealer Wins!</div></h1>')

