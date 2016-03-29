import sys

def update_board():
    board_next = [[0 for x in range (8)] for x in range (8)]
    for a in range (len(board)):
        for i in range (len(board[a])):
            n = (board[(a-1)%8][i] + board[(a+1)%8][i] + board[a][(i+1)%8] +
                 board[a][(i-1)%8] + board[(a+1)%8][(i+1)%8] + board[(a-1)%8][(i+1)%8] +
                 board[(a-1)%8][(i-1)%8] + board[(a+1)%8][(i-1)%8])
            if (n == 3 or (board[a][i] and n == 2)):
                board_next[a][i] = 1
                
    return board_next

def print_board():
    for a in range (len(board)):
        for i in range (len(board[a])):
            print board[a][i],
        print ""
    print ""
    
def print_tv():
    for a in range(len(board)):
        for i in range (len(board)-1-a): sys.stdout.write("0")
        sys.stdout.write("1");
        for i in range (a): sys.stdout.write("0"),
        print "_",
        for i in range (len(board[a])): sys.stdout.write(str(int(not bool(board[a][i])))),
        print ""
    print ""

    
board = [
[0,0,0,1,1,0,0,0],
[0,0,1,1,0,0,0,0],
[0,0,0,1,0,0,0,0],
[0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0],
]
iters = 4

for i in range (7):
    print_tv()

board = update_board()

for i in range (iters):
    for i in range(8):
        print_tv()
    board = update_board()
