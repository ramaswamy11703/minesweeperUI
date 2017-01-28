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
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
    
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
        cell.myLabel.text = "?"

            //}
        //}
        
        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        //how to differentiate between one and two click???
        print("You selected cell #\(indexPath.item)!")
        
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
                        cell.myLabel.text = String(board.gameBoard[x][y].neighboringMines)
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
                        }
                    }
                }
            }
            
        }
        else {
        }
        
        
        
    
    }

    // override func viewDidLoad() {
        // super.viewDidLoad()
        // self.collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    //}
}



