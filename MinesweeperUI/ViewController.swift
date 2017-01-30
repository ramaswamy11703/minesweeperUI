//
//  ViewController.swift
//  MinesweeperUI
//
//  Created by Shekar Ramaswamy on 1/22/17.
//  Copyright © 2017 Shekar Ramaswamy. All rights reserved.
//
    
import UIKit
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    
    var board = Board(size: 10)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        board.setupBoard(testing: false)
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board.size * board.size
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        var row:Int
//        var col:Int
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        
//        row = indexPath.item / board.size
//        col = indexPath.item % board.size
//        
//        
//        if (board.gameBoard[row][col].isRevealed) {
//            cell.myLabel.text = String(board.gameBoard[row][col].neighboringMines)
//        }
//        else {
//            if (board.gameBoard[row][col].isFlagged) {
//                cell.myLabel.text = "F"
//            }
//            else {
        //cell.myLabel.text = "?"
        cell.myImage.image = #imageLiteral(resourceName: "unknown")

            //}
        //}
        
        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        //how to differentiate between one and two click???
        
        var row:Int
        var col:Int
        
        row = indexPath.item / board.size
        col = indexPath.item % board.size
        
        
        let userPassed = board.handleClick(row: row, col: col)
        
        if (userPassed)
        {
            for x in 0 ..< board.size {
                for y in 0 ..< board.size {
                    var cell:MyCollectionViewCell
                    var ip:IndexPath
                    
                    ip = IndexPath(item: (x*board.size)+y, section: 0)
                    cell = collectionView.cellForItem(at: ip) as! MyCollectionViewCell
                    
                    if (board.gameBoard[x][y].isRevealed) {
                        //cell.myLabel.text = String(board.gameBoard[x][y].neighboringMines)
                        let number = board.gameBoard[x][y].neighboringMines
                        if (number == 0) {
                            cell.myImage.image = #imageLiteral(resourceName: "zero")
                        }
                        if (number == 1) {
                            cell.myImage.image = #imageLiteral(resourceName: "one")
                        }
                        else if (number == 2) {
                            cell.myImage.image = #imageLiteral(resourceName: "two")
                        }
                        else if (number == 3) {
                            cell.myImage.image = #imageLiteral(resourceName: "three")
                        }
                        else if (number == 4) {
                            cell.myImage.image = #imageLiteral(resourceName: "four")
                        }
                        else if (number == 5) {
                            cell.myImage.image = #imageLiteral(resourceName: "five")
                        }
                    }
                    else {
                        if (board.gameBoard[row][col].isMine) {
                            cell.myLabel.text = "M"
                        }
                        else if (board.gameBoard[row][col].isFlagged){
                            cell.myLabel.text = "F"
                            continue
                        }
                        else {
                            cell.myLabel.text = "?"
                            cell.myImage.image = #imageLiteral(resourceName: "unknown")
                        }
                    }
                }
            }
            
        }
        else {
            //user lost. game over.
        }
    }
     override func viewDidLoad()
     {
         super.viewDidLoad()
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(recognizer:))
//        tap.numberOfTapsRequired = 2
//        view.addGestureRecognizer(tap)
    }
    
//    func doubleTapped(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
//    {
//        var row:Int
//        var col:Int
//        
//        row = indexPath.item / board.size
//        col = indexPath.item % board.size
//        
//        var cell:MyCollectionViewCell
//        var ip:IndexPath
//        
//        ip = IndexPath(item: (row*board.size)+col, section: 0)
//        cell = collectionView.cellForItem(at: ip) as! MyCollectionViewCell
//        
//        if (board.gameBoard[row][col].isFlagged) {
//            cell.myLabel.text = "F"
//        }
//        
//        let userWon = board.flagCell(row: row, col: col)
//        if (userWon)
//        {
//            //user won! game over
//        }
//
//    }
}



