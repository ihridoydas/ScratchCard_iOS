//
//  ScratchCardView.swift
//  ScratchCard
//
//  Created by hridoy das on 2023/12/20.
//

import SwiftUI

struct ScratchCardView: View {
    @State var currentPathState = [CGPoint]()
    
    init() {
           UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
       }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack{
                    // MARK: Scratchable overlay view
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 250, height: 250)
                    Image("bg", bundle: nil)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(20)
               

                    // MARK: Hidden content view
                    Image("bg", bundle: nil)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(20)
                        .overlay {
                            Image("won", bundle: nil)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                        }
                        .mask(
                            Path { path in
                                path.addLines(currentPathState)
                            }.stroke(style: StrokeStyle(lineWidth: 50, lineCap: .round, lineJoin: .round))
                        )
                        .gesture(
                            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                .onChanged({ value in
                                    currentPathState.append(value.location)
                                })
                        )
                }
                
            }
            .navigationBarTitle (Text("Scratch Card"), displayMode: .automatic)
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button{
                        currentPathState.removeAll()
                    } label: {
                        Label("Clear",systemImage: "clear.fill")
                    }
                }
            }
            .accentColor(.red)
        }
        
    }
}

struct ScratchCardViewPreview: PreviewProvider {
    static var previews: some View {
        ScratchCardView()
    }
}
