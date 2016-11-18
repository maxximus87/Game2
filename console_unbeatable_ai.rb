class UnbeatableAI
    attr_accessor :marker


    def initialize(marker)
        @marker = marker    
    end

    def valid_space?(board, choice)
        board[choice] == ""
    end

    def get_move(board)
        comp_marker = marker

        if comp_marker == "O"
            player_marker = "X"
        else
            player_marker = "O"
        end

        if potential_win_block(board, comp_marker) <= 8
            move = potential_win_block(board, comp_marker)
        elsif potential_win_block(board, player_marker) <= 8
            move = potential_win_block(board, player_marker)
        else
            move = board.index("")
        end
        move
    end

    def win_combinations(board)
        a = [
            [board[0],board[1],board[2]],
            [board[3],board[4],board[5]],
            [board[6],board[7],board[8]],
            [board[0],board[3],board[6]],
            [board[1],board[4],board[7]],
            [board[2],board[5],board[8]],
            [board[0],board[4],board[8]],
            [board[2],board[4],board[6]],
        ]
    end

    def win_positions
        win_positions = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    end

    def potential_win_block(board, current_marker)
        
        open_spot = 10

        win_combinations(board).each_with_index do |winner, index|
            if winner.count(current_marker) == 2 && winner.count("") == 1
                winning_player = winner.index("")
                open_spot = win_positions[index][winning_player]
            end
        end
        open_spot
    end


    

end



