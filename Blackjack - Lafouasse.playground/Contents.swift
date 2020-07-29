enum Suit: Int {
    case Spades, Hearts, Diamonds, Clubs
    
    func symbol() -> Character {
        switch self {
        case .Spades:
            return "♠"
        case .Hearts:
            return "♥"
        case .Diamonds:
            return "♦"
        case .Clubs:
            return "♣"
        }
    }
}

enum Rank: Int {
    case Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King
    
    func value() -> String {
        switch self {
        case .Ace:
            return "A"
        case .Jack:
            return "J"
        case .Queen:
            return "Q"
        case .King:
            return "K"
        default:
            return String(rawValue + 1)
        }
    }
}

class Card {
    let suit: Suit
    let rank: Rank
    
    init(suit: Suit, rank: Rank) {
        self.suit = suit
        self.rank = rank
    }
}

class Player {
    var name: String
    var hand: [Card] = []
    
    init(name: String) {
        self.name = name
    }
    
    func handDescription () {
        print("\(self.name)'s hand :")
        for card in hand {
            print("\(card.rank.value())\(card.suit.symbol())", terminator: " ")
        }
    }
    
    

    func score() -> Int {
        var total = 0
        
        for card in hand {
            switch card.rank {
            case .Jack, .Queen, .King:
                total += 10
            default:
                total += card.rank.rawValue + 1
            }
        }
        return total
    }
    
    
    func reset() {
        hand.removeAll()
    }
}


class Round {
    var deck: [Card] = []
    var player : Player
    var dealer : Player
    
    init(player: Player, dealer: Player) {
        
            for suit_num in 0...3 {
                let suit = Suit(rawValue: suit_num)!
                for rank_num in 0...12 {
                    let rank = Rank(rawValue: rank_num)!
                    deck.append(Card(suit: suit, rank: rank))
                }
            }

        deck.shuffle()
        
        self.player = player
        self.dealer = dealer
    }
 

    func dealTo(player: Player) -> Card? {
        if let card = deck.first {
            player.hand.append(card)
            deck.remove(at: 0)
            return card
        }
        return nil
    }
    
    func startGame() {
        for _ in 0..<2 {dealTo(player: player)}
        player.handDescription()
        print("")
        print("Starting at \(player.score()) points")
        print("")
        dealTo(player: dealer)
        dealer.handDescription()
        print("")
        print("")
    }
    
    func dealToDealer () {
        dealTo(player: dealer)
        dealer.handDescription()
        print("")
        print("Le Dealer starts at \(dealer.score()) points")
        print("")
    }
    
    func win(){
        print("Congratulations, \(player.name)")
    }
    
    func lose(){
        print("Too bad, \(player.name)")
    }
    
    func blackjack(){
        print("Blackjack !")
    }
    
}


// Initialize Player and Dealer -> Append them to a Round
var PlayerOne: Player = Player(name: "Alex")
var TheDealer: Player = Player(name: "The Dealer")
var thisRound: Round = Round(player: PlayerOne, dealer: TheDealer)


//Starting the game
thisRound.startGame()

while thisRound.player.score() < 17 {
    thisRound.dealTo(player: thisRound.player)
    thisRound.player.score()
}
thisRound.player.handDescription()
print("")
print("Stay at \(thisRound.player.score()) points")
print("")


if thisRound.player.score() > 21 {
    thisRound.lose()
}

else if thisRound.player.score() == 21{
    thisRound.blackjack()
    
} else {

// Continue the game by dealing to the Dealer
thisRound.dealToDealer()

while thisRound.dealer.score() < thisRound.player.score(){
    thisRound.dealTo(player: thisRound.dealer)
}

thisRound.dealer.handDescription()
print("")
print("Le Dealer stays at \(thisRound.dealer.score())")
print("")
    
    if thisRound.dealer.score() > 21{
        thisRound.win()
    } else if thisRound.dealer.score() == 21 {
         thisRound.blackjack()
    }
    else {
        thisRound.lose()
    }
}



