class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end
class PlayerStrategyError < StandardError ; end

def rps_game_winner(game)
    raise WrongNumberOfPlayersError unless game.length==2
    game.each do |pair|
        raise PlayerStrategyError unless pair.length==2
        strategy=pair[1].upcase
        raise NoSuchStrategyError unless strategy=="P" or strategy=="S" or strategy=="R"
    end
    compare_strategy(game[0],game[1])
end

def compare_strategy(player1,player2)
    if player1[1]==player2[1]
        return player1
    end
    if player1[1]=="P"
        if player2[1]=="S"
            player2
        else
            player1
        end
    elsif player1[1]=="S"
        if player2[1]=="P"
            player1
        else
            player2
        end
    else
        if player2[1]=="P"
            player2
        else
            player1
        end
    end
end
        
puts rps_game_winner([["David","S"],["Omer","S"]])

class InvalidTournamentError < StandardError ; end
def rps_tournament_winner(tournament)
    raise InvalidTournamentError unless tournament.length==2
    if tournament[0][0].instance_of?(String)
        compare_strategy(tournament[0],tournament[1])
    else
        compare_strategy(rps_tournament_winner(tournament[0]),
                         rps_tournament_winner(tournament[1]))
    end
end

t=[
    [
        [ ["Armando", "P"], ["Dave", "S"] ],
        [ ["Richard", "R"],  ["Michael", "S"] ],
],
[ 
    [ ["Allen", "S"], ["Omer", "P"] ],
    [ ["David E.", "R"], ["Richard X.", "P"] ]
]
]
#puts rps_tournament_winner(t)
