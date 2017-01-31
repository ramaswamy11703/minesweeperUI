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
        var row:Int
        var col:Int
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        let tap1 = UITapGestureRecognizer(target: cell, action: #selector(MyCollectionViewCell.singleTap(_:)))
        tap1.numberOfTapsRequired = 1
        cell.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: cell, action: #selector(MyCollectionViewCell.doubleTap(_:)))
        tap2.numberOfTapsRequired = 2
        cell.addGestureRecognizer(tap2)
        tap1.require(toFail: tap2)
        
        
        row = indexPath.item / board.size
        col = indexPath.item % board.size
        cell.row = row
        cell.col = col
        cell.vc = self

        cell.myImage.image = #imageLiteral(resourceName: "unknown")

        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    

     override func viewDidLoad()
     {
         super.viewDidLoad()
     }
    
    func singleTap(row:Int, col:Int)
    {
        
        print("singleTap")
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
                        if (board.gameBoard[x][y].isMine) {
                            cell.myLabel.text = "M"
                        }
                        else if (board.gameBoard[x][y].isFlagged) {
                            cell.myImage.image = #imageLiteral(resourceName: "flag")
                            continue
                        }
                        else {
                            cell.myImage.image = #imageLiteral(resourceName: "unknown")
                        }
                    }
                }
            }
            
        }
        else {
            let gameOver = UIAlertController(title: "BOOM", message: "You hit a mine! Game over.", preferredStyle: UIAlertControllerStyle.alert)
            gameOver.addAction(UIAlertAction(title: ":(", style: UIAlertActionStyle.default, handler: nil))
            self.present(gameOver, animated:true, completion: nil)
            
            //self.performSegue(withIdentifier: "homeScreen", sender:self)
        }

    }
    
    func doubleTap(row:Int, col:Int)
    {
        print("double tap")
        var cell:MyCollectionViewCell
        var ip:IndexPath
        
        ip = IndexPath(item: (row*board.size)+col, section: 0)
        cell = collectionView.cellForItem(at: ip) as! MyCollectionViewCell
        

        let userWon = board.flagCell(row: row, col: col)
        
        if (board.gameBoard[row][col].isFlagged) {
            cell.myImage.image = #imageLiteral(resourceName: "flag")
        }
        
        if (userWon)
        {
            let gameWon = UIAlertController(title: "Congrats!", message: "You won the game!!!", preferredStyle: UIAlertControllerStyle.alert)
            gameWon.addAction(UIAlertAction(title: ":)", style: UIAlertActionStyle.default, handler: nil))
            self.present(gameWon, animated:true, completion: nil)
            
            //self.performSegue(withIdentifier: "homeScreen", sender:self)

            
        }
        
            }

    }





