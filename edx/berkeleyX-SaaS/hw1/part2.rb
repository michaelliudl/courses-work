class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

Strategies = ['R', 'P', 'S']

class String
    def beats(other)
        raise NoSuchStrategyError unless Strategies.find_index(self) && Strategies.find_index(other)
        (self == 'R' && other == 'S') || (self == 'S' && other == 'P') || (self == 'P' && other == 'R')
    end
end

def is_player(match)
    match.length == 2 && match[0].class == String
end
def rps_result(m1, m2)
    if is_player(m1) && is_player(m2)
        rps_game_winner([m1, m2])
    else
        rps_result(rps_result(m1[0], m1[1]), rps_result(m2[0], m2[1]))
    end
  # YOUR CODE HERE
end

def rps_game_winner(game)
    raise WrongNumberOfPlayersError unless game.length == 2
    game.each do |g|
        raise NoSuchStrategyError unless g.length == 2
        s = g[1].upcase
        raise NoSuchStrategyError unless Strategies.find_index s
    end
    s1 = game[0][1].upcase
    s2 = game[1][1].upcase
    if s1 == s2
        game[0]
    elsif s1.beats s2
        game[0]
    else
        game[1]
    end
  # YOUR CODE HERE
end

def rps_tournament_winner(tournament)
    rps_result tournament[0], tournament[1]
  # YOUR CODE HERE
end
game1 = [ ["Armando", "P"], ["Dave", "S"] ]
#puts rps_game_winner game1
tour1 = [
        [
                    [ ["Armando", "P"], ["Dave", "S"] ],
                            [ ["Richard", "R"],  ["Michael", "S"] ],
                                ],
                                    [
                                                [ ["Allen", "S"], ["Omer", "P"] ],
                                                        [ ["David E.", "R"], ["Richard X.", "P"] ]
                                                            ]
]
puts rps_tournament_winner tour1
