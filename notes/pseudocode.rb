Board
  reports missed hit when no ship at position
  can have a ship
  does not allow ships outside the board
  can receive a hit on a ship
  can receive a hit on a sub
  can report if all ships are sunk
  can report if not all ships are sunk
  collisions
    does not allow ships to overlap on their starting position
    does not allow ships to overlap on their other positions

Destroyer
  has size 3
  knows all positions when facing north
  knows all positions when facing east
  knows all positions when facing south
  knows all positions when facing west
  gets hit in any of the positions it is in
  should handle collisions on start position
  should handle collisions on location other than start position
  should not be able to be hit more than once in the same place

Battleships
  should support a game with many ships being hit and missed

Player
  can lose
  can place ships
  can tell us when a ship is hit
  can report hit positions
  can report miss positions
  will lose if all ships are hit

Ship
  has a position when created
  can be hit
  will record number of hits
  can be missed
  will not be hit when it is missed
  is not sunk initially
  can be sunk
  can be collided with

Submarine
  has size 2
  knows all positions when facing north
  knows all positions when facing east
  knows all positions when facing south
  knows all positions when facing west
  gets hit in any of the positions it is in
  should handle collisions on start position
  should handle collisions on location other than start position
  should not be able to be hit more than once in the same place
