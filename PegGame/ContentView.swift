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
    
    let rows = [GridItem(), GridItem(),GridItem(),GridItem(),GridItem(),]
    
    var body: some View {
        NavigationView {
            ZStack
            {
                Color.black.ignoresSafeArea()
                VStack{
                    HStack
                    {
                        Peg(circleColor: .blue)
                    }
                    HStack
                    {
                        Peg(circleColor: .blue)
                        Peg(circleColor: .blue)
                    }
                    HStack
                    {
                        Peg(circleColor: .blue)
                        Peg(circleColor: .blue)
                        Peg(circleColor: .blue)
                    }
                    HStack
                    {
                        Peg(circleColor: .blue)
                        Peg(circleColor: .blue)
                        Peg(circleColor: .blue)
                        Peg(circleColor: .blue)
                    }
                    HStack
                    {
                        Peg(circleColor: .blue)
                        Peg(circleColor: .blue)
                        Peg(circleColor: .blue)
                        Peg(circleColor: .blue)
                        Peg(circleColor: .blue)
                    }
                }
            }
        }
    }
}


struct Peg: View {
    var squareColor = Color.black
    var circleColor: Color
    
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
