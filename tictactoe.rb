empty_fields = [1, 2, 3, 4, 5, 6, 7, 8, 9]

board_fields = {1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 6 => " ", 7 => " ", 8 => " ", 9 => " "}

@game = true


def game_instruction
    puts ""
    puts "Let's play Tic-Tac-Toe!"
    print "\n" * 2
    puts " 1 | 2 | 3    The positions to play on the tic-tac-toe board are"
    puts "---|---|---   represented by number 1-9 as shown."
    puts " 4 | 5 | 6    To place an 'X' or 'O' in a certain position,"
    puts "---|---|---   simply enter the number of that position."
    puts " 7 | 8 | 9 "
    puts ""
end

def players
    puts "Player 1, would you like to be X or O? "
    $player1 = gets.chomp

        if $player1 == "X"
            $player2 = "O"
        else
            $player2 = "X"
        end

    puts "Great! Player 1 is #{$player1} and Player 2 is #{$player2}"
    puts ""
    
end

def draw_board(bf)
    puts ""
    puts "Let's get started!'"
    puts ""
    puts "Sample board with numbers:"
    puts ""
    puts " 1 | 2 | 3 "
    puts "---+---+---"
    puts " 4 | 5 | 6 "
    puts "---+---+---"
    puts " 7 | 8 | 9 "
    puts ""
    puts "Game Board:"
    puts ""
    puts " #{bf[1]} | #{bf[2]} | #{bf[3]} "
    puts "---+---+---"
    puts " #{bf[4]} | #{bf[5]} | #{bf[6]} "
    puts "---+---+---"
    puts " #{bf[7]} | #{bf[8]} | #{bf[9]} "
    puts ""
end


def fill_fields(bf, ef)
    bf.each do |key, value|
        if value != " "
            ef.delete(key)
        end
    end
end


def full_board?(ef)
    if ef == []
        puts "It's a tie!"
        @game = false
    end
end


def winner?(bf)
    winning = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    winning.each do |element|
        if bf[element[0]] == "X" && bf[element[1]] == "X" && bf[element[2]] == "X"
            puts "Congratulations! Player X has won!"
            @game = false
            exit #this ends the game so there won't be two winners'
        elsif bf[element[0]] == "O" && bf[element[1]] == "O" && bf[element[2]] == "O"
            puts "Congratulations! Player O has won!"
            @game = false
        end
    end
end


game_instruction
players
draw_board(board_fields)


while @game

    
    puts "Player 1, choose an empty field (1-9):"

    chosen_field1 = gets.chomp.to_i
    

    board_fields[chosen_field1] = "#{$player1}"
    fill_fields(board_fields, empty_fields)
    draw_board(board_fields)
    winner?(board_fields)
    full_board?(empty_fields)


    puts "Player 2, choose an empty field (1-9):"

    chosen_field2 = gets.chomp.to_i

    board_fields[chosen_field2] = "#{$player2}"
    fill_fields(board_fields, empty_fields)
    draw_board(board_fields)
    winner?(board_fields)
    full_board?(empty_fields)

end

