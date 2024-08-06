//
//  ContentView.swift
//  PegGame
//
//  Created by Caesar Gutierrez on 12/6/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    init()
    {
        pegGameManager = PegGameManager()
    }
    
    @ObservedObject var pegGameManager : PegGameManager
    
    var body: some View {
        NavigationView {
            VStack(spacing:0)
            {
                ZStack{
                    Color.black
                    .ignoresSafeArea()
                    HStack
                    {
                        Spacer()
                        VStack
                        {
                            Button(
                                action: {
                                    pegGameManager.ResetGame()
                                }, label: {
                                    Image(systemName: "arrow.clockwise")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                })
                            .padding()
                        }
                    }
                    
                }
                .frame(height: 40)
                ZStack
                {
                    Color.black.ignoresSafeArea()
                    VStack{
                        ForEach(pegGameManager.PegGame, id: \.self) { pegLane in
                            HStack{
                                ForEach(pegLane, id: \.self) { peg in
                                    let pegView = PegView(peg: peg)
                                    pegView
                                        .onTapGesture {
                                            pegGameManager.CheckBoard(peg: pegView.peg)
                                        }
                                }
                            }
                        }
                        
                    }
                }
                
            }
        }
    }
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
            if (peg.isCleared)
            {
                Circle()
                    .fill(.green)
                    .frame(width: 60, height: 65)
            }
            Circle()
                .fill(peg.isCleared ? .black : peg.circleColor)
                .frame(width: 50, height: 50)
            
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
