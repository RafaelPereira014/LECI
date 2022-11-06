import asyncio
from copy import deepcopy
import getpass
import json
import os
import copy
from types import FrameType
import websockets
from shape import *



async def agent_loop(server_address="localhost:8000", agent_name="student"):
    async with websockets.connect(f"ws://{server_address}/player") as websocket:

        # Receive information about static game properties
        await websocket.send(json.dumps({"cmd": "join", "name": agent_name}))

        while True:
            try:
                state = json.loads(
                    await websocket.recv()
                )  # receive game update, this must be called timely or your game will get out of sync with the server
                
                key = ""
                for event in state:
                    if event == 'game' and state["game"] != []:
                        game = state["game"]
                        piece = state['piece']
                
                        print("Game: ",game)

                        a = game_field(game)
                        b = choice(a,piece)
                        if b != []:                          
                            play = run_ai(b)
                            print("play: ",play)
                            for key in play:
                                
                                json.loads(
                                    await websocket.recv()
                                )   
                                
                                response = await websocket.send(
                                    json.dumps({"cmd": "key", "key": key})
                                )  
                                
                                print("key: ",key,response)
                                #break
            except websockets.exceptions.ConnectionClosedOK:
                print("Server has cleanly disconnected us")
                return
  
  #---------------------------------------------------------------------#
  # PIECE
bottom = [[i, 30] for i in range(10)] 
lateral = [[0, i] for i in range(30)]
lateral.extend([[10-1,i] for i in range(30)])
grid = bottom + lateral

def run_ai(move): 
    keys = []
    
    bestMove = move.get('x')
    bestRotation = move.get('rotation')

    tmpW = 0
    while(tmpW < bestRotation):
        keys.append("w")
        tmpW +=1
    keys.append("a")
    keys.append("a")
    keys.append("a")
    keys.append("a")

    if(bestMove > 0):
        tmpD= 0
        while(tmpD < bestMove):
            keys.append("d")
            tmpD +=1
            
    elif(bestMove < 0):
        tmpA = 0
        while(tmpA < abs(bestMove)):
            keys.append("a")
            tmpA+=1
    
    keys.append("s")
    
    return keys

def choice(fields,piece):
    current_piece = []
    
    if piece == [[3, 3], [4, 3], [3, 4], [4, 4]]:
        current_piece = SHAPES[3] #O
        
    elif piece == [[4, 2], [4, 3], [4, 4], [5, 4]]:
        current_piece = SHAPES[6] #L
        
    elif piece == [[4, 2], [5, 2], [4, 3], [4, 4]]:
        current_piece = SHAPES[4] #J
        
    elif piece == [[4, 2], [4, 3], [5, 3], [5, 4]]:
        current_piece = SHAPES[0] #S
        
    elif piece == [[2, 2], [3, 2], [4, 2], [5, 2]]:
        current_piece = SHAPES[2]   #I
        
    elif piece == [[4, 2], [3, 3], [4, 3], [3, 4]]:
        current_piece = SHAPES[1] #Z

    elif piece == [[4, 2], [4, 3], [5, 3], [4, 4]]:
        current_piece = SHAPES[5] #T
    else:
        return []
    
    
    final_maps=set_FinalPiece(fields, piece)

    print("final maps : ",len(final_maps))
    best_move = {'score': None,'x': 0,'rotation': 0, 'map': []}
    for map in final_maps:
        map["score"] = heuristic(map['map'])
        if best_move['score']==None or best_move['score'] < map["score"]:
            best_move['score'] = map['score'] 
            best_move['x'] = map['x']
            best_move['map'] = map['map']
            best_move['rotation'] = map['rotation']
            best_move['original_piece'] = map['original_piece']
            best_move['final_piece'] = map['final_piece']



        
    for l in best_move['original_piece']:
        print(l)
    print()
    for l in best_move['final_piece']:
        print(l)
    print()
    for l in best_move['map']:
        print(l)
    
    print("Best: ", best_move['x'],best_move['rotation'],best_move["score"])
    
    return best_move

def set_FinalPiece(fields, piece):
    n_piece=normalize_piece(piece)

    piece_translation=[]
    piece_translation.append(n_piece)

    if len(piece_translation[0][0])>len(piece_translation[0]) or len(piece_translation[0][0])<len(piece_translation[0]):
        for i in range(3):
            tmp=[]
            guide_piece=piece_translation[i]
            tmp = [[0 for c in range(0,len(guide_piece))] for i in range(0,len(guide_piece[0]))]

            for x in range(len(guide_piece[0])):
                for y in range(len(guide_piece)):
                    tmp[len(guide_piece[0])-x-1][y]=guide_piece[y][x]

            piece_translation.append(tmp)
            print()

        different=len(piece_translation[0][0])*len(piece_translation[0])
        for x in range(len(piece_translation[0][0])):
            for y in range(len(piece_translation[0])):
                if piece_translation[0][y][x] == piece_translation[2][y][x]:
                    different-=1

        if different==0:
            del piece_translation[-1]
            del piece_translation[-1]
            
    if len(piece_translation)==4:
        tmp_permutation=piece_translation[1]
        piece_translation[1]=piece_translation[3]
        piece_translation[3]=tmp_permutation
    
    lista = [0 for c in range(0,8)]

    for i in range(len(lista)):
        ums = 29
        for l in fields:
            if l[i]==1:
                break
            else:
                ums-=1
        lista[i]=ums

    height_max=max(lista)

    valid_maps=[]
    rotation=0
    for permutated_piece in piece_translation:
        for h in range(height_max+1):
            board_max_y=28-h
            for board_guide_x in range(9-len(permutated_piece[0])):
                setted_fields= copy.deepcopy(fields)
                valid=True
                support=False

                total_ones_till_place=0
                for j in range(board_max_y-len(permutated_piece)+1):
                    guide_j=j
                    for l in permutated_piece:
                        for x in range(len(permutated_piece[0])):
                            # setted_fields[guide_j][board_guide_x+x]=2
                            if (l[x]==1 and fields[guide_j][board_guide_x+x]==1):
                                total_ones_till_place+=1
                                break
                        if total_ones_till_place>0:
                            break
                        guide_j+=1

                for x in range(len(permutated_piece[0])):
                    for y in range(len(permutated_piece)):
                        y_index=len(permutated_piece)-y-1
                        
                        if permutated_piece[y_index][x]==0:
                            continue

                        if permutated_piece[y_index][x]==1 and fields[board_max_y-y][board_guide_x+x]==1:
                            valid=False
                            break

                        if permutated_piece[y_index][x]==1:
                            setted_fields[board_max_y-y][board_guide_x+x]=permutated_piece[y_index][x]
                            # setted_fields[board_max_y-y][board_guide_x+x]=8
                        under_y=board_max_y-y+1
                        if board_max_y==28 or fields[under_y][board_guide_x+x]==1:
                            support=True

                if valid and support and total_ones_till_place==0:
                    #x_translate=[-4,-3,-2,-1,0,1,2,3]
                    
                    x_translate=[0,1,2,3,4,5,6,7]
                    valid_maps.append({"total_ones":total_ones_till_place, "map": setted_fields, "x":x_translate[board_guide_x], "rotation": rotation, "original_piece":piece_translation[0], "final_piece": permutated_piece})
        rotation+=1
    
    print("\n\n###############################################")
   
    return valid_maps


def normalize_piece(piece):
    min_x=500
    min_y=500

    piece_molder = [[0 for c in range(0,4)] for i in range(0,5)]

    for c in piece:
        if c[0]<min_x:
            min_x=c[0]

        if c[1]<min_y:
            min_y=c[1]

    i=0
    for c in piece:
        piece[i][0]-=min_x
        piece[i][1]-=min_y
        piece_molder[piece[i][1]][piece[i][0]]=1
        i+=1

    
    rights=[]
    for l in piece_molder:
        for i in range(len(l)):
            if l[len(l)-i-1]==1:
                rights.append(i)
                break

    if rights[0]==0:
        rights[0]=4

    tmp_piece= [[0 for c in range(0,min(rights))] for i in range(0,len(rights))]

    for x in range(len(tmp_piece)):
        for y in range(len(tmp_piece[0])):
            tmp_piece[x][y]=piece_molder[x][y]

    return tmp_piece


def game_field(game):
    
    map = [[0 for c in range(0,8)] for i in range(0,29)]
    
    for g in game:
        map[g[1]-1][g[0]-1] = 1
    
    
    return map

#---------------------------------------------------------------------#        
def heuristic(game):

# Para o score:
# minimizar altura
# maximizar nº de cleared lines
# minimizar o nº de buracos
# minimizar o nº de "bumpiness" : diferenta de altura entre colunas
   
    score = 0
    # a = -0.510066 
    a = -0.410066 
    b = 0.760666
    c = -0.35663
    d = -0.184483 

    score= a*(height_field(game)) + b*(complete_line_field(game)) + c*(holes_field(game)) + d*(bumpiness_field(game))
    return score


def height_field(game):
    a = 0
    lista = [0 for c in range(0,8)]
    
    for i in range(len(lista)):
        ums = 29
        for l in game:
            if l[i] == 1:
                break
            else:
                ums -= 1
        lista[i] = ums
        
    a = sum(lista)

    return a

def complete_line_field(game):
    full_line = 0
    a = 0
    for i in range(0,29):
        a = sum(game[28-i])
        if a == 8:
            full_line+=1
                
    return full_line



def bumpiness_field(game):
    bumpiness = 0
    lista = [0 for c in range(0,8)]

    
    for x in range(len(game[0])):
        for y in range(len(game)):
            if game[y][x] == 1:
                lista[x] = 29 - y
                break
                
    for i in range(len(lista)-1):
        
        bumpiness+=abs(lista[i]-lista[i+1])

    print("Bumpiness: ",bumpiness,lista)
    
    return bumpiness


def holes_field(game):
    number_holes=0
    for i in range(len(game[0])):
        found_one=False
        for l in game:
            if l[i] == 1:
                found_one=True
            elif(l[i] == 0 and found_one):
                number_holes+=1
    print("Holes: ",number_holes)
    return number_holes


# DO NOT CHANGE THE LINES BELLOW
# You can change the default values using the command line, example:
# $ NAME='arrumador' python3 client.py
loop = asyncio.get_event_loop()
SERVER = os.environ.get("SERVER", "localhost")
PORT = os.environ.get("PORT", "8000")
NAME = os.environ.get("NAME", getpass.getuser())
loop.run_until_complete(agent_loop(f"{SERVER}:{PORT}", NAME))