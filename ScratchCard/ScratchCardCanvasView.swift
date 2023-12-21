//
//  ScratchCardCanvasView.swift
//  ScratchCard
//
//  Created by hridoy das on 2023/12/20.
//

import SwiftUI

struct Line {
    var points = [CGPoint]()
    var lineWidth: Double = 50.0
}

struct ScratchCardCanvasView: View {
    @State private var currentLine = Line()
    @State private var lines = [Line]()
    
    init() {
           UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
       }
    
    var body: some View {
        
        NavigationView {
            VStack {
                ZStack {
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
                            Canvas { context, _ in
                                for line in lines {
                                    var path = Path()
                                    path.addLines(line.points)
                                    context.stroke(path,
                                                   with: .color(.white),
                                                   style: StrokeStyle(lineWidth: line.lineWidth,
                                                                      lineCap: .round,
                                                                      lineJoin: .round)
                                    )
                                }
                            }
                        )
                        .gesture(
                            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                .onChanged({ value in
                                    let newPoint = value.location
                                    currentLine.points.append(newPoint)
                                    lines.append(currentLine)
                                })
                        )
                }
            }
            .navigationBarTitle (Text("Scratch Card Canvas"), displayMode: .automatic)
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button{
                        currentLine.points.removeAll()
                        lines.removeAll()
                    } label: {
                        Label("Clear",systemImage: "clear.fill")
                    }
                }
            }
            .accentColor(.red)
        }
  
    }
}

struct ScratchCardCanvasViewPreview: PreviewProvider {
    static var previews: some View {
        ScratchCardCanvasView()
    }
}
