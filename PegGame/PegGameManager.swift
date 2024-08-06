//
//  PegGameManager.swift
//  PegGame
//
//  Created by Caesar Gutierrez on 7/20/24.
//

import Foundation
import SwiftUI

class PegGameManager:ObservableObject
{
    @Published var PegGame: [[Peg]]
    @Published var SelectedPeg: Peg?
    
    
    init()
    {
        PegGame = SetUpTrianglePeg()
    }
    
    func SetSelectedPeg(peg: Peg)
    {
        //Can't select a cleared slot.
        if (peg.isCleared)
        {
            return
        }
        
        if let selectedPeg = SelectedPeg {
            selectedPeg.isSelected = false
        }
        peg.isSelected = true
        SelectedPeg = peg
    }
    func CheckBoard(peg: Peg)
    {
        print(peg.Position())
        
        if (peg.isCleared)
        {
            MoveSelected(peg: peg)
            return
        }
        
        SetSelectedPeg(peg: peg)
        
    }
    
    func ResetGame()
    {
        PegGame = SetUpTrianglePeg()
    }
    
    func MoveSelected(peg: Peg)
    {
        guard let selectedPeg = SelectedPeg else {return}
        
        let selectedCol = selectedPeg.col
        let selectedRow = selectedPeg.row
        
        let moveToCol = peg.col
        let moveToRow = peg.row
        
        let col = GetMidDistance(moveToPos: moveToCol, selectedPos: selectedCol)
        let row = GetMidDistance(moveToPos:  moveToRow, selectedPos: selectedRow)
        
        guard let col = col else {return}
        guard let row = row else {return}
        
        let pegToEat = PegGame[row][col]
        if (pegToEat.isCleared || pegToEat == peg)
        {
            return
        }
        
        pegToEat.isCleared = true
        
        peg.row = selectedRow
        peg.col = selectedCol
        PegGame[selectedRow][selectedCol] = peg
        
        selectedPeg.row = moveToRow
        selectedPeg.col = moveToCol
        PegGame[moveToRow][moveToCol] = selectedPeg
    }
    
    private func GetMidDistance(moveToPos: Int, selectedPos: Int) -> Int?
    {
        let distance = (moveToPos - selectedPos)
        if (abs(distance) == 0)
        {
            return selectedPos
        }
        else if (abs(distance) > 3)
        {
            // We can't possibly move to that location.
            return nil
        }
        else
        {
            return distance < 0 ? selectedPos - 1 : selectedPos + 1
            
        }
    }
}


func SetUpTrianglePeg() -> [[Peg]]
{
    var pegGame: [[Peg]] = []
    for row in 0..<5 {
        var pegLane: [Peg] = []
        for col in 0...row{
            let peg = Peg(row: row,col: col)
            pegLane.append(peg)
            
        }
        pegGame.append(pegLane)
    }
    //FIXME:   Set top peg as cleared as default for now.
    pegGame[0][0].isCleared = true
    
    return pegGame
}
func RandomColor () -> Color {
    let colors: [Color] = [.blue, .red, .yellow, .white]
    let randomIndex = Int.random(in: 0..<colors.count)
    return colors[randomIndex]
}

// Peg Object
class Peg: Identifiable, Hashable, ObservableObject
{
    static func == (lhs: Peg, rhs: Peg) -> Bool {
        return lhs.id == rhs.id
        
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    var id: UUID
    var squareColor = Color.black
    var circleColor = RandomColor()
    var row: Int
    var col: Int
    @Published var isCleared = false
    @Published var isSelected = false
    init(row: Int, col: Int)
    {
        self.row = row
        self.col = col
        id = UUID()
    }
    public func Position() -> String {
        return "COL:\(col)-ROW:\(row)"
    }
}
