//
//  PegGameManager.swift
//  PegGame
//
//  Created by Caesar Gutierrez on 7/20/24.
//

import Foundation
import SwiftUI

class PegGameManager
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
   
}


func SetUpTrianglePeg() -> [[Peg]]
{
    var pegGame: [[Peg]] = []
    for row in 0...5 {
        var pegLane: [Peg] = []
        for col in 0..<row{
            let peg = Peg(row: row,col: col)
            pegLane.append(peg)
            
        }
        pegGame.append(pegLane)
    }
    //FIXME:   Set top peg as cleared as default for now.
    pegGame[1][0].isCleared = true
    print(pegGame[1][0].Position())

    return pegGame
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
        return "\(col)-\(row)"
    }
    
}
