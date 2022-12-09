#dont_main.nim 
import strutils
import std/random
import std/os
import std/tables
import std/osproc

var in_play_boxes : seq[int]
var play_box_num : int
var player_box_prize : int

  
proc clear_cons()=
  case system.hostOS
  of "windows":
    discard os.execShellCmd("cls")
  of "linux":
    discard os.execShellCmd("clear")

proc five_sec_sleep()=
  os.sleep(5000)

proc three_sec_sleep()=
    os.sleep(3000)

proc two_sec_sleep()=
    os.sleep(2000)

#proc pre_game_init()=
echo "this works!"

var money_prize = @[0.01,0.10,0.50,1.00,5.00,10.00,50.00,100.00,250.00,500.00,750.00,1000.00,3000.00,5000.00,10000.00,15000.00,20000.00,35000.00,50000.00,75000.00,100000.00,250000.00]

var erad_mon_priz : seq[float64] = @[]

var boxes : seq[int] = @[]

var box_table = initTable[int, float64]()


for z in countup(1,22):
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

proc count_avail_box()=
  for k in keys(box_table):
    if k == play_box_num : continue 
    in_play_boxes.add(k)
  
  echo in_play_boxes
  #echo box_table 

proc input_and_verify():int=
  var f_test = 0
  
  let box_selec = parseInt(readLine(stdin))
  case box_selec
  of 1..22:
    for i in keys(box_table):
      if i == box_selec:
        f_test = f_test+1

  else:
    echo "invalid box selection, please try again"
    var retry = input_and_verify()

  #echo "reached this point"
  if f_test == 1:
    return box_selec

proc avail_boxes_pick()=
    echo "These are your available boxes"
    echo ""
    count_avail_box()
    echo ""
    echo "Please enter the box number you would like to pick"
    echo ""


proc check_and_result(selec_box : int)=
  var box_result : float64
  var test = 0
  #echo selec_box
  for i in keys(box_table):
    #echo i
    if i == selec_box:
      test = test+1
  #echo test

  if test == 1:
    box_result = box_table[selec_box]
    clear_cons()
    two_sec_sleep()
    echo "The box you selected had £"& $box_result
    erad_mon_priz.add(box_result)
    box_table.del(selec_box)
    #return box_result


proc disp_money_board(mon_inp : float64)=
  var space_gap : string
  var blanker = ""
  var blanker_2 = ""
  var comp_mon_priz =       @[0.01,0.10,0.50,1.00,5.00,10.00,50.00,100.00,250.00,500.00,750.00,1000.00,3000.00,5000.00,10000.00,15000.00,20000.00,35000.00,50000.00,75000.00,100000.00,250000.00]
  #echo "in disp money board"
  for i in countup(0,10):

    var print_out_1 = $comp_mon_priz[i]
    var print_out_2 = $comp_mon_priz[i+11]

    if comp_mon_priz[i] in erad_mon_priz:
      print_out_1 = blanker

    if comp_mon_priz[i+11] in erad_mon_priz:
      print_out_2 = blanker_2
      
        
    

    if comp_mon_priz[i] == 0.01:
      space_gap = "         "
    if comp_mon_priz[i] == 0.1 or comp_mon_priz[i] == 0.5 or comp_mon_priz[i] == 1.0 or comp_mon_priz[i] == 5.0:
      space_gap = "          "
    if comp_mon_priz[i] == 10.0 or comp_mon_priz[i] == 50.0:
      space_gap = "         "
    if comp_mon_priz[i] == 100.0 or comp_mon_priz[i] == 250.0 or comp_mon_priz[i] == 500.0 or comp_mon_priz[i] == 750.0:
      space_gap = "        "
    echo print_out_1&space_gap&print_out_2
    

proc round_one()=
    echo "Welcome to the the first round"
    three_sec_sleep()
    clear_cons()
    avail_boxes_pick()
    #echo "got to this point"
    var valid_return = input_and_verify()
    check_and_result(valid_return)
    disp_money_board(0.0)

    ### next box selection
    five_sec_sleep()
    clear_cons()
    avail_boxes_pick()
    valid_return = input_and_verify()
    check_and_result(valid_return)
    disp_money_board(0.0)
    
    

proc pre_round_one()= 

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
      play_box_num = play_box
      three_sec_sleep()
      clear_cons()
      round_one()
      
    else:
      clear_cons()
      echo "Your box selection is invalid, please try again"
      three_sec_sleep()
      pre_round_one()
      


proc game_menu()=
    #pre_game_init()
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
    echo "Type x for a debug option"
    echo ""
    
    #case statement
    
    try: 
        let menus_selec = readLine(stdin)
        case menus_selec
        of "1":
            clear_cons()
            echo "start game"
            pre_round_one()
        of "2":
            clear_cons()
            echo "leaderboard"
        of "3":
            clear_cons()
            echo "credits"
        of "4":
            clear_cons()
            echo "quit"
        of "x":
            clear_cons()
            disp_money_board(0.0)
        else:
            echo "your selection was invalid, please try again"
            three_sec_sleep()
            game_menu()
            
    except EOFError:
        echo "Random ass error"
    
game_menu()



let quit_selec = readLine(stdin)


      
    
    
    

