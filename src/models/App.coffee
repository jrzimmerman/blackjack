# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  checkBlackJack: ->
    player = if (@get('playerHand').minScore() is 11) && @get('playerHand').hasAce() && (@get('playerHand').size() is 2)
      @get('playerHand').blackjack = true
      true
    else
      false

    dealer = if (@get('dealerHand').minScore() is 11) && @get('dealerHand').hasAce() && (@get('dealerHand').size() is 2)
      @get('dealerHand').blackjack = true
      true
    else
      false

    if player && dealer
      return 'draw'
    if player
      return 'player'
    if dealer
      return 'dealer'
    'noone'
