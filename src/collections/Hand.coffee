class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    # @score = 0
    @standing = false
    @blackjack = false

  hit: ->
    @add(@deck.pop()).last()

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    # @score = @minScore()
    score = [@minScore(), @minScore() + 10 * @hasAce()]

    if @blackjack then [21]

    if @standing
      if score[0] is score[1]
        return [score[0]]
      if score[0] < score[1] < 22
        return [score[1]]
      if score[1] > 21
        return [score[0]]

    return score


  stand: ->
    @standing = true


