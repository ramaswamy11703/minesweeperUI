//
//  Board.swift
//  MinesweeperCommandLine
//
//  Created by Shekar Ramaswamy on 1/17/17.
//  Copyright © 2017 Shekar Ramaswamy. All rights reserved.
//

import Foundation

class Board
{
    let size:Int
    var gameBoard : [[MinesweeperObject]]
    init(size:Int)
    {
        self.size = size
        gameBoard = []
    }
    
    /**
     Sets mines and assigns neighboring mines for non mine spaces
     */
    func setupBoard(testing:Bool)
    {
        //assigns mines and non mine spaces
        
        for row in 0 ..< size
        {
            var minesweeperRow:[MinesweeperObject] = []
            for col in 0 ..< size
            {
                //1 in size chance that space is a mine
                let randomNum = arc4random_uniform(UInt32(size))
                if (randomNum == 1)
                {
                    let mObject = MinesweeperObject(row: row, col: col, neighboringMines: 0, isMine: !testing)
                    minesweeperRow.append(mObject)
                }
                else
                {
                    let mObject = MinesweeperObject(row: row, col: col, neighboringMines: 0, isMine: false)
                    minesweeperRow.append(mObject)
                }
                
            }
            gameBoard.append(minesweeperRow)
        }
        setupValues()
        
    }
    
    func setupValues()
    {
        //assigns number of surrounding mines per space (mine algorithm called)
        for row in 0 ..< size
        {
            for col in 0 ..< size
            {
                let mObject = gameBoard[row][col]
                if (!mObject.isMine)
                {
                    let surroundingMines = self.findMines(row: row, col: col)
                    mObject.neighboringMines = surroundingMines
                }
            }
        }
    }
    
    //for testing only
    func setupMine(row:Int, col:Int)
    {
        gameBoard[row][col].isMine = true
    }
    
    /**
     Finds surrounding mines for a certain square
     */
    func findMines(row:Int, col:Int) -> Int
    {
        var counter = 0
        
        for x in row - 1 ..< row + 2
        {
            for y in col - 1 ..< col + 2
            {
                if (x < 0 || x >= size) {
                    continue
                }
                if (y < 0 || y >= size) {
                    continue
                }
                if (x == row && y == col) {
                    continue
                }
                
                if (gameBoard[x][y].isMine) {
                    counter = counter + 1
                }
            }
        }
        
        return counter
    }
    
    /**
     Modifies board based on click. Returns false if user loses, true if the user continues.
     */
    func handleClick(row:Int, col:Int) -> Bool
    {
        let mObject = gameBoard[row][col]
        
        if (mObject.isMine)
        {
            print("Game over. You clicked a mine")
            return false
        }
        
        if (mObject.isFlagged) {
            mObject.isFlagged = false
        }
        
        //clicked on square already revealed
        if (mObject.isRevealed) {
            return true
        }
        
        mObject.isRevealed = true
        
        expandClick(row: row, col: col)
        
        return true
        //main user handling click method
    }
    
    func expandClick(row:Int, col:Int)
    {
        var locations = [MinesweeperObject]()
        let mObject = gameBoard[row][col]
        
        locations.append(mObject)
        
        repeat {
            var tempLocations = [MinesweeperObject]()
            for m in locations
            {
                for x in m.row - 1 ..< m.row + 2
                {
                    for y in m.col - 1 ..< m.col + 2
                    {
                        if (x < 0 || x >= size) {
                            continue
                        }
                        if (y < 0 || y >= size) {
                            continue
                        }
                        if (x == m.row && y == m.col) {
                            continue
                        }
                        
                        if (gameBoard[x][y].isRevealed) {
                            continue
                        }
                        if (gameBoard[x][y].isMine) {
                            continue
                        }
                        if (gameBoard[x][y].isFlagged) {
                            continue
                        }
                        //not revealed, has neighboring mines
                        if (gameBoard[x][y].neighboringMines > 0) {
                            gameBoard[x][y].isRevealed = true
                        }
                        //not revealed, empty space. spread expansion from this square in later call
                        if (gameBoard[x][y].neighboringMines == 0)
                        {
                            gameBoard[x][y].isRevealed = true
                            tempLocations.append(gameBoard[x][y])
                        }
                        
                    }
                }
                //locations = locations.filter() { $0 !== m }
                
            }
            locations.removeAll()
            locations.append(contentsOf: tempLocations)
            
        } while (locations.count != 0)
        
    }
    
    /**
     Returns true if the user has won, false if the user has not
     */
    func flagCell(row:Int, col:Int) -> Bool
    {
        gameBoard[row][col].isFlagged = !gameBoard[row][col].isFlagged
        
        for x in 0 ..< size
        {
            for y in 0 ..< size
            {
                if (gameBoard[x][y].isMine && !gameBoard[x][y].isFlagged) {
                    return false
                }
            }
        }
        
        print("You won the game. Congratulations.")
        return true
    }
    
    func testMyLogic() {
        // create board
        // expose a cell
        // print
        // flag a cell
    }
    
    /**
     Prints the game board for further usage
     */
    func printBoard(printAll:Bool)
    {
        //var colIndex = 0
        
        for row in 0 ..< size
        {
            //            if (row == 0)
            //            {
            //                print(" ", terminator: "")
            //                for index in 0 ..< size
            //                {
            //                    print(" " + String(index), terminator: "")
            //                }
            //                print("\n")
            //            }
            for col in 0 ..< size
            {
                //                if (col == 0)
                //                {
                //
                //                    print(String(colIndex) + " ", terminator: "")
                //                    colIndex += 1
                //                }
                
                if (gameBoard[row][col].isFlagged)
                {
                    print("F ", terminator: "")
                    continue
                }
                
                if (gameBoard[row][col].isRevealed || printAll)
                {
                    if (gameBoard[row][col].isMine) {
                        print("M ", terminator: "")
                    }
                    else
                    {
                        print(String(gameBoard[row][col].neighboringMines) + " ", terminator: "")
                    }
                }
                else
                {
                    //                    //REMOVE LATER
                    if (gameBoard[row][col].isMine) {
                        print("! ", terminator: "")
                    }
                    else {
                        print("? ", terminator: "")
                    }
                }
            }
            print("")
            
        }
    }
    
    func play()
    {
        
        
    }
}
