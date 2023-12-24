//
//  ContentView.swift
//  PegGame
//
//  Created by Caesar Gutierrez on 12/6/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    init() {
        pegGame = SetUpTrianglePeg()
    }
    let rows = [GridItem(), GridItem(),GridItem(),GridItem(),GridItem(),]
    let pegGame : [[PegView]]
    
    var body: some View {
        NavigationView {
            ZStack
            {
                Color.black.ignoresSafeArea()
                VStack{
                    ForEach(pegGame, id: \.self) { pegLane in
                        HStack{
                            ForEach(pegLane, id: \.self) { peg in
                               peg
                            }
                        }
                    }
                    
                }
            }
        }
    }
}

func RandomColor () -> Color {
    let colors: [Color] = [.blue, .red, .yellow, .white]
    let randomIndex = Int.random(in: 0..<colors.count)
    return colors[randomIndex]
}
func SetUpTrianglePeg() -> [[PegView]] {
    var pegGame: [[PegView]] = []
    for row in 0...5 {
        var pegLane: [PegView] = []
        for peg in 0..<row{
            let pegView = PegView(circleColor: RandomColor() ,row: row, col: peg)
            pegLane.append(pegView)
        }
        pegGame.append(pegLane)
    }
    return pegGame
}

struct PegView: View, Hashable {
    var squareColor = Color.black
    var circleColor: Color
    var row: Int
    var col: Int
    
    var body: some View {
        // Square with Circle
        ZStack {
            Rectangle()
                .fill(squareColor)
                .frame(width: 60, height: 60)
            Circle()
                .fill(circleColor)
                .frame(width: 50, height: 50)
        }
    }
   
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
