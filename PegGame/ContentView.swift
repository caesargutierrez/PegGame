//
//  ContentView.swift
//  PegGame
//
//  Created by Caesar Gutierrez on 12/6/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    init() {
        pegGame = SetUpTrianglePeg()
    }
    
//    Triangle Peg Game
    let rows = [GridItem(), GridItem(),GridItem(),GridItem(),GridItem(),]
    var pegGame : [[Peg]]
    
    @State var selectedPegView: PegView?
    
    var body: some View {
        NavigationView {
            ZStack
            {
                Color.black.ignoresSafeArea()
                VStack{
                    ForEach(pegGame, id: \.self) { pegLane in
                        HStack{
                            ForEach(pegLane, id: \.self) { peg in
                                let pegView = PegView(peg: peg)
                                pegView
                                    .onTapGesture {
                                        SetSelectedPeg(pegView: pegView)
                                    }
                            }
                        }
                    }
                    
                }
            }
        }
    }
    private func SetSelectedPeg(pegView: PegView)
    {
        print("TAPPED")
        selectedPegView?.peg.isSelected = false
        selectedPegView = pegView
        // We Know it is not nill by now, we just assigned it.
        selectedPegView!.peg.isSelected = true
    }
}

func RandomColor () -> Color {
    let colors: [Color] = [.blue, .red, .yellow, .white]
    let randomIndex = Int.random(in: 0..<colors.count)
    return colors[randomIndex]
}

func SetUpTrianglePeg() -> [[Peg]] {
    var pegGame: [[Peg]] = []
    for row in 0...5 {
        var pegLane: [Peg] = []
        for col in 0..<row{
            let peg = Peg(row: row,col: col)
            pegLane.append(peg)
            
        }
        pegGame.append(pegLane)
    }
    return pegGame
}
// View
struct PegView: View
{
    @ObservedObject var peg: Peg
    init(peg: Peg) {
        self.peg = peg
    }
    
    var body: some View {
        // Square with Circle
        ZStack {
            Rectangle()
                .fill(peg.squareColor)
                .frame(width: 60, height: 60)
            if (peg.isSelected)
            {
                Circle()
                    .fill(.orange)
                    .frame(width: 65, height: 65)
            }
            Circle()
                .fill(peg.circleColor)
                .frame(width: 50, height: 50)
                    
        }
    }
   
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
    @Published var isSelected = false
    init(row: Int, col: Int)
    {
        self.row = row
        self.col = col
        id = UUID()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
