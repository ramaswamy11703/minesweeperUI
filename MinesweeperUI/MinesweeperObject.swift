//
//  MinesweeperObject.swift
//  MinesweeperCommandLine
//
//  Created by Shekar Ramaswamy on 1/17/17.
//  Copyright © 2017 Shekar Ramaswamy. All rights reserved.
//

import Foundation

class MinesweeperObject
{
    let row:Int
    let col:Int
    
    var isRevealed = false
    
    var neighboringMines:Int
    var isMine:Bool
    var isFlagged = false
    
    init(row:Int, col:Int, neighboringMines:Int, isMine:Bool)
    {
        self.row = row
        self.col = col
        self.neighboringMines = neighboringMines
        self.isMine = isMine
    }
    
}
