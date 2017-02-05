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
    
    @IBOutlet weak var topView: UIView!
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    
    var board = Board(size: 10)
    var bombView:UIImageView! = nil
    var swiftTimer = Timer()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        board.setupBoard(testing: false)
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board.size * board.size
    }
    

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
            let centerP = self.view.center
            
            bombView = UIImageView(frame: CGRect(x: 0, y:0, width: 50, height: 50))
            bombView.image = #imageLiteral(resourceName: "bomb")
            bombView.alpha = 0.5
            
            topView.insertSubview(bombView, aboveSubview: collectionView)
            
            let timing = UICubicTimingParameters(animationCurve:.easeIn)
            let animator = UIViewPropertyAnimator(duration: 1.0, timingParameters:timing)
            animator.addAnimations {
                self.bombView.alpha = 1.0
                self.bombView.center.x = centerP.x
                self.bombView.center.y = centerP.y
                
                let scaleTrans = CGAffineTransform(scaleX:2, y:2)
                let angle = CGFloat(M_PI)
                let rotateTrans = CGAffineTransform(rotationAngle: angle)
                scaleTrans.concatenating(rotateTrans)
                self.bombView.transform = scaleTrans
            }
            animator.startAnimation()
            
            swiftTimer = Timer.scheduledTimer(timeInterval: 2, target:self, selector: #selector(ViewController.showAlert),
                                              userInfo: nil, repeats: false)
            
        }
        
    }
    
    func showAlert()
    {
        bombView.removeFromSuperview()
        let gameOver = UIAlertController(title: "BOOM", message: "You hit a mine! Game over.", preferredStyle: UIAlertControllerStyle.alert)
        gameOver.addAction(UIAlertAction(title: ":(", style: UIAlertActionStyle.default) { action in
            self.performSegue(withIdentifier: "boardToHome", sender:self) })
        self.present(gameOver, animated:true, completion: nil)
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
            gameWon.addAction(UIAlertAction(title: ":)", style: UIAlertActionStyle.default) { action in
                self.performSegue(withIdentifier: "boardToHome", sender:self) })
            self.present(gameWon, animated:true, completion: nil)
        }
        
            }

    }





