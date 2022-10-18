#dont_main.nim 
import strutils
import std/random
import std/os
import std/tables
import std/osproc




  
proc clear_cons()=
  case system.hostOS
  of "windows":
    discard os.execShellCmd("cls")
  of "linux":
    discard os.execShellCmd("clear")
    
proc three_sec_sleep()=
    os.sleep(3000)

proc pre_game_init()=
    echo "this works!"

    var money_prize = @[0.01,0.10,0.50,1.00,5.00,10.00,50.00,100.00,250.00,500.00,750.00,1000.00,3000.00,5000.00,10000.00,15000.00,20000.00,35000.00,50000.00,75000.00,100000.00,250000.00]
    var boxes : seq[int] = @[]

    var box_table = initTable[int, float64]()


    for z in countup(0,21):
        #allocating prize money to random boxes.
        randomize()

        #echo money_prize.len()
        var random_index = rand(money_prize.len()-1)
        #box_table[z] = money_prize[random_index]
        var money_sum = money_prize[random_index]

        #echo type(z)
        #echo type(money_sum)
    
        box_table[z] = money_sum
        money_prize.del(random_index)


    echo box_table

##proc count_avail_box()=
    ##for b in box_table:
      ##echo "b"

proc round_one()=
    echo "Welcome to the the first round"
    three_sec_sleep()
    clear_cons()
    #count_avail_box()


proc play_game()= 
    echo "Welcome to deal or no deal"
    three_sec_sleep()
    clear_cons()
    echo "Please pick a box between 1 and 22"
    echo ""
    let play_box = parseInt(readLine(stdin))
    case play_box
    of 1..22:
      clear_cons()
      echo "Your box is number "& $play_box
      three_sec_sleep()
      clear_cons()
      
    else:
      clear_cons()
      echo "Your box selection is invalid, please try again"
      three_sec_sleep()
      play_game()
      


proc game_menu()=
    pre_game_init()
    echo "in menus"
    clear_cons()
    #start
    echo "Hello and welcome to deal or no deal"
    three_sec_sleep()
    clear_cons()
    echo "Please Select an optiom"
    echo ""
    echo "Type 1 to start the game"
    echo "Type 2 to view the leaderboard"
    echo "Type 3 to view the credits"
    echo "Type 4 to quit the game"
    echo ""
    
    #case statement
    
    try: 
        let menus_selec = readLine(stdin)
        case menus_selec
        of "1":
            clear_cons()
            echo "start game"
            play_game()
        of "2":
            clear_cons()
            echo "leaderboard"
        of "3":
            clear_cons()
            echo "credits"
        of "4":
            clear_cons()
            echo "quit"
        else:
            echo "your selection was invalid, please try again"
            three_sec_sleep()
            game_menu()
            
    except EOFError:
        echo "Random ass error"
    
game_menu()
    
let quit_selec = readLine(stdin)


      
    
    
    

