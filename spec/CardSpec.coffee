assert = chai.assert
describe "card model", ->

  describe "deck constructor", ->

    it "should create a card collection", ->
      collection = new Deck()
      assert.strictEqual collection.length, 52

  describe "new card", ->

    it "should be ace of clubs", ->
      card = new Card({rank: 1, suit: 2})
      assert.strictEqual card.get("rankName"), "Ace"
      assert.strictEqual card.get("suitName"), "Clubs"
